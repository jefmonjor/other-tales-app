import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
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
      onRequest: (options, handler) async {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          try {
            await Supabase.instance.client.auth.refreshSession();
            final newSession = Supabase.instance.client.auth.currentSession;
            if (newSession != null) {
              e.requestOptions.headers['Authorization'] =
                  'Bearer ${newSession.accessToken}';
              final response = await dio.fetch(e.requestOptions);
              return handler.resolve(response);
            }
          } catch (refreshError) {
            debugPrint('Token refresh failed: $refreshError');
          }
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}
