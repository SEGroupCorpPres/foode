import 'package:foode/core/utils/typedefs.dart';

abstract class OnboardingRepository {
  const OnboardingRepository();

  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
