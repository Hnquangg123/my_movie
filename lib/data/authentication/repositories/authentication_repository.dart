import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final GoTrueClient _supabaseAuth;
  static const String _redirectUrl =
      'io.supabase.flutterexample://signup-callback';

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

  @override
  Future<AuthResponse> signInWithGoogle() async {
    final webClientId =
        '590919030590-8pbkbjkjgfhqck3fk850852tjbhahs80.apps.googleusercontent.com';

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: webClientId,
      );  

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // Handle case where user cancels sign-in
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled.');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      return _supabaseAuth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      print('Google Sign-In Error: $e');
      throw Exception('Failed to sign in with Google.');
    }
  }
}
