import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:foode/features/onboarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repository;
  late CheckIfUserIsFirstTimer usecase;
  setUp(() {
    repository = MockOnboardingRepository();
    usecase = CheckIfUserIsFirstTimer(repository);
  });
  test('should get a response from [MockOnboardingRepository]', () async {
    // arrange
    when(
      () => repository.checkIfUserIsFirstTimer(),
    ).thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase();
    // assert
    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repository.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
