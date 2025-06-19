import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/features/onboarding/data/data_sources/local/onboarding_local_data_sources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences preferences;
  late OnboardingLocalDataSource localDataSource;
  setUp(() {
    preferences = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(preferences);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache the data', () async {
      when(
        () => preferences.setBool(any(), any()),
      ).thenAnswer((_) async => true);
      await localDataSource.cacheFirstTimer();
      verify(() => preferences.setBool(kFirstTimerKey, false));
      verifyNoMoreInteractions(preferences);
    });
    test(
      'should throw [CacheException] when there is an error caching the data',
      () async {
        when(() => preferences.setBool(any(), any())).thenThrow(Exception());
        final methodCall = localDataSource.cacheFirstTimer;
        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(preferences);
      },
    );
  });
  group('checkIfUserIsFirstTimer', () {
    test(
      'should call [SharedPreferences] to check if user is first timer'
      'and return the right response from storage when data exists',
      () async {
        when(() => preferences.getBool(any())).thenReturn(false);
        final result = await localDataSource.checkIfUserIsFirstTimer();
        expect(result, false);
        verify(() => preferences.getBool(kFirstTimerKey));
        verifyNoMoreInteractions(preferences);
      },
    );
    test('should return [true] when there is no data in storage', () async {
      when(() => preferences.getBool(any())).thenReturn(null);
      final result = await localDataSource.checkIfUserIsFirstTimer();
      expect(result, true);
      verify(() => preferences.getBool(kFirstTimerKey));
      verifyNoMoreInteractions(preferences);
    });
    test('should throw [CacheException] when there is an error ', () async {
      when(() => preferences.getBool(any())).thenThrow(Exception());
      final methodCall = localDataSource.checkIfUserIsFirstTimer();
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => preferences.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(preferences);
    });
  });
}
