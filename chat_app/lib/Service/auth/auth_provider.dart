
import 'auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createuser({
    required String email,
    required String password,
  });

  Future<void> logout();
  Future<void> sendEmailVerfication();
  Future<void>initializeApp();
}
