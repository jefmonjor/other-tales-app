import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env.dart';

part 'dio_provider.g.dart';

/// Lock para evitar múltiples refreshes simultáneos (Thundering Herd).
Completer<void>? _refreshCompleter;
bool _isRefreshing = false;

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      // ─── REQUEST: Inyectar JWT ───────────────────────────────────
      onRequest: (options, handler) async {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        return handler.next(options);
      },

      // ─── ERROR: Silent Token Refresh ─────────────────────────────
      onError: (DioException e, handler) async {
        // Solo interceptamos 401 Unauthorized
        if (e.response?.statusCode != 401) {
          return handler.next(e);
        }

        // Guard: Si esta petición YA es un reintento, no entrar en loop infinito.
        // Forzamos logout porque el token recién refrescado tampoco funcionó.
        if (e.requestOptions.extra['_isRetry'] == true) {
          debugPrint('🔒 Retry also got 401 → forcing logout');
          await _forceLogout();
          return handler.next(e);
        }

        try {
          // ── Thundering Herd Prevention ──
          // Si ya hay un refresh en curso, esperamos a que termine.
          // Si no, somos nosotros los que lo iniciamos.
          if (_isRefreshing) {
            // Otro request ya está refrescando → esperamos
            debugPrint('⏳ Waiting for ongoing token refresh...');
            await _refreshCompleter?.future;
          } else {
            // Nosotros somos los primeros → refrescamos
            _isRefreshing = true;
            _refreshCompleter = Completer<void>();

            try {
              debugPrint('🔄 Refreshing Supabase session...');
              await Supabase.instance.client.auth.refreshSession();
              debugPrint('✅ Token refreshed successfully');
              _refreshCompleter!.complete();
            } catch (refreshError) {
              debugPrint('❌ Token refresh failed: $refreshError');
              _refreshCompleter!.completeError(refreshError);
              _isRefreshing = false;

              // Refresh falló → logout y propagar error original
              await _forceLogout();
              return handler.next(e);
            } finally {
              _isRefreshing = false;
            }
          }

          // ── Reintentar la petición original con el nuevo token ──
          final newSession = Supabase.instance.client.auth.currentSession;
          if (newSession != null) {
            // Clonar la petición con el nuevo token y marcarla como reintento
            final retryOptions = e.requestOptions
              ..headers['Authorization'] = 'Bearer ${newSession.accessToken}'
              ..extra['_isRetry'] = true;

            final response = await dio.fetch(retryOptions);
            return handler.resolve(response);
          } else {
            // No hay sesión después del refresh → logout
            debugPrint('🔒 No session after refresh → forcing logout');
            await _forceLogout();
            return handler.next(e);
          }
        } catch (retryError) {
          // Cualquier error inesperado durante el retry → propagar original
          debugPrint('❌ Retry failed: $retryError');
          return handler.next(e);
        }
      },
    ),
  );

  return dio;
}

/// Fuerza el cierre de sesión en Supabase.
/// El AuthStateListener en el frontend redirigirá al login automáticamente.
Future<void> _forceLogout() async {
  try {
    await Supabase.instance.client.auth.signOut();
    debugPrint('🚪 Forced logout completed');
  } catch (e) {
    debugPrint('⚠️ Error during forced logout: $e');
  }
}

