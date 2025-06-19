import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  CacheFirstTimer(this._repository);

  final OnboardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer(); //=>
}
