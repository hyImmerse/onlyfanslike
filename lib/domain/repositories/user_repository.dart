import 'package:creator_platform_demo/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<User> login(String email, String password);
  Future<User> register({
    required String email,
    required String password,
    required String name,
  });
  Future<void> logout();
  Future<User> updateProfile(User user);
  Future<bool> isLoggedIn();
}