import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/features/onboarding/data/data_sources/local/onboarding_local_data_sources.dart';
import 'package:foode/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource dataSource;
  late OnboardingRepositoryImpl repositoryImpl;
  setUp(() {
    dataSource = MockOnboardingLocalDataSource();
    repositoryImpl = OnboardingRepositoryImpl(dataSource);
  });
  test('should be a subclass of [OnboardingRepository] ', () {
    expect(repositoryImpl, isA<OnboardingRepository>());
  });
  group('cacheFirstTimer', () {
    test(
      'should complete successfully when call to local data source is successful',
      () async {
        when(
          () => dataSource.cacheFirstTimer(),
        ).thenAnswer((_) async => Future.value());
        final result = await repositoryImpl.cacheFirstTimer();
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => dataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
    test(
      'should return [CacheFailure]  when call to local data source is unsuccessful',
      () async {
        when(
          () => dataSource.cacheFirstTimer(),
        ).thenThrow(const CacheException(message: 'Insufficient storage'));
        final result = await repositoryImpl.cacheFirstTimer();
        expect(
          result,
          Left<CacheFailure, void>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => dataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
  group('checkIfUserIsFirstTimer', () {
    test('should return true when user is first timer', () async {
      when(
        () => dataSource.checkIfUserIsFirstTimer(),
      ).thenAnswer((_) async => true);
      final result = await repositoryImpl.checkIfUserIsFirstTimer();
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test('should return false when user is not first timer', () async {
      when(
        () => dataSource.checkIfUserIsFirstTimer(),
      ).thenAnswer((_) async => Future.value(false));
      final result = await repositoryImpl.checkIfUserIsFirstTimer();
      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test(
      'should return a [CacheFailure] when call to local data source is unsuccessful',
      () async {
        when(
          () => dataSource.checkIfUserIsFirstTimer(),
        ).thenThrow(const CacheException(message: 'Insufficient storage'));
        final result = await repositoryImpl.checkIfUserIsFirstTimer();
        expect(
          result,
          Left<CacheFailure, bool>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
}
