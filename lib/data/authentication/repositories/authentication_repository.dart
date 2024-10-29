import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final GoTrueClient _supabaseAuth;
  static const String _redirectUrl =
      'io.supabase.flutterquickstart://login-callback/';

  AuthenticationRepository(this._supabaseAuth);

  @override
  Stream<User?> getCurrentUser() => _supabaseAuth.onAuthStateChange.map(
        (event) => event.session?.user,
      );

  @override
  User? getSignedInUser() => _supabaseAuth.currentUser;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      await _supabaseAuth.signInWithPassword(
        password: password,
        email: email,
      );

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _supabaseAuth.signUp(
        password: password,
        email: email,
        emailRedirectTo: _redirectUrl,
      );

  @override
  Future<void> signOut() async => await _supabaseAuth.signOut();
}
