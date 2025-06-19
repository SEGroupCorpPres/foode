import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/domain/entity/user.dart';

abstract class AuthRepository {
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userdata,
  });
}
