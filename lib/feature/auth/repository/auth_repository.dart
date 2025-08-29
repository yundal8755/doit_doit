import 'package:doit_doit/feature/auth/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<void> signOut();
}
