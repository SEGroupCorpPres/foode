import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/onboarding/data/data_sources/local/onboarding_local_data_sources.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer()async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch(e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
