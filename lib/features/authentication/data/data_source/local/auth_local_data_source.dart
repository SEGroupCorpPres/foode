import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/features/authentication/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required String userData,
  });
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn({required String email, required String password, required String fullName}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required UpdateUserAction action, required String userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
