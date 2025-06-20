import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/features/onboarding/domain/use_cases/cache_first_timer.dart';
import 'package:foode/features/onboarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:foode/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock implements CheckIfUserIsFirstTimer {}

void main() {
  late MockCacheFirstTimer cacheFirstTimer;
  late MockCheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnboardingCubit onboardingCubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    onboardingCubit = OnboardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });
  final tFailure = CacheFailure(
    message: 'Insufficient storage',
    statusCode: 4032,
  );

  test('initial state should be [OnboardingInitial]', () {
    expect(onboardingCubit.state, const OnboardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CachingFirstTimer, UserCached] when successful',
      build: () {
        when(
          () => cacheFirstTimer(),
        ).thenAnswer((_) async => const Right(null));
        return onboardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const <OnboardingState>[CachingFirstTimer(), UserCached()],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CachingFirstTimer, OnboardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer((_) async => Left(tFailure));
        return onboardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => <OnboardingState>[
        const CachingFirstTimer(),
        OnboardingError(message: tFailure.message),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });
  group('checkIfUserIsFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckIfUserIsFirstTimer, OnboardingStatus] when successful',
      build: () {
        when(
          () => checkIfUserIsFirstTimer(),
        ).thenAnswer((_) async => const Right(false));
        return onboardingCubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const <OnboardingState>[
        CheckingIfUserIsFirstTimer(),
        OnboardingStatus(isFirstTimer: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckIfUserIsFirstTimer, OnboardingState(true)] when unsuccessful',
      build: () {
        when(
          () => checkIfUserIsFirstTimer(),
        ).thenAnswer((_) async => Left(tFailure));
        return onboardingCubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const <OnboardingState>[
        CheckingIfUserIsFirstTimer(),
        OnboardingStatus(isFirstTimer: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
  });
}
