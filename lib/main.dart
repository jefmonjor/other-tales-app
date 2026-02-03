import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://gsslwdruiqtlztupekcd.supabase.co',
    ),
    anonKey: const String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdzc2x3ZHJ1aXF0bHp0dXBla2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAxNDc2MDMsImV4cCI6MjA4NTcyMzYwM30.SDcpN02aXOrVRDua8Ybkt0-fsmkIXXBNuAPQ3kPLmn4',
    ),
  );

  // Desktop Window Configuration
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    try {
      await windowManager.ensureInitialized();

      const windowOptions = WindowOptions(
        minimumSize: Size(400, 800),
        size: Size(1200, 800),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        title: 'Other Tales',
      );

      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    } catch (e) {
      debugPrint('Failed to initialize window_manager: $e');
      // Continue app execution even if window manager fails
    }
  }

  runApp(
    const ProviderScope(
      child: OtherTalesApp(),
    ),
  );
}
