/// Environment configuration.
/// Values are injected at compile time via --dart-define.
class Env {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://gsslwdruiqtlztupekcd.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdzc2x3ZHJ1aXF0bHp0dXBla2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAxNDc2MDMsImV4cCI6MjA4NTcyMzYwM30.SDcpN02aXOrVRDua8Ybkt0-fsmkIXXBNuAPQ3kPLmn4',
  );

  /// Base URL for the Spring Boot backend API.
  /// Should point to: https://<backend-host>/api/v1
  /// All repository paths (e.g. /projects, /chapters/{id}) are relative to this.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://gsslwdruiqtlztupekcd.supabase.co/functions/v1',
  );
}
