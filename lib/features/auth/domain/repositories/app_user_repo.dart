import 'package:auth_app/features/auth/domain/entities/app_user.dart';

abstract class AppUserRepo {
  Future<AppUser?> logInWithEmail(String email, String password);
  Future<AppUser?> createWithEmail(String name, String email, String password);
  Future<void> logOut();
  Future<AppUser?> getCurrentUser();
}