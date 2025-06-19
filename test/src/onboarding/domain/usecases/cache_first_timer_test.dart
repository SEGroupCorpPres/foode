import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:foode/features/onboarding/domain/use_cases/cache_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repository;
  late CacheFirstTimer usecase;
  setUp(() {
    repository = MockOnboardingRepository();
    usecase = CacheFirstTimer(repository);
  });
  test(
    'should call the [OnboardingRepository.cacheFirstTimer] and return the right data',
    () async {
      when(() => repository.cacheFirstTimer()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
        ),
      );
      final result = await usecase();
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
          ),
        ),
      );
      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
