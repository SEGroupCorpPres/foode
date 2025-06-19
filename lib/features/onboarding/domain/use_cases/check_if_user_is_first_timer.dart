import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  CheckIfUserIsFirstTimer(this._repository);

  final OnboardingRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.checkIfUserIsFirstTimer();
}
