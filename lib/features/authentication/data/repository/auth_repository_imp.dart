import 'package:dartz/dartz.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:foode/features/authentication/domain/entity/user.dart';
import 'package:foode/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  const AuthRepositoryImp(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _authRemoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({required String email, required String password}) async {
    try {
      final user = await _authRemoteDataSource.signIn(email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.signUp(email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userdata,
  }) async {
    try {
      await _authRemoteDataSource.updateUser(action: action, userData: userdata);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
