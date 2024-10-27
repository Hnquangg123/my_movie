import 'package:gotrue/src/types/user.dart';
import 'package:my_movie/domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Stream<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  User? getSignedInUser() {
    // TODO: implement getSignedInUser
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
