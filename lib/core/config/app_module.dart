import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

@module
abstract class AppModule {
  GoTrueClient get supabaseAuth => Supabase.instance.client.auth;

  @singleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;
}
