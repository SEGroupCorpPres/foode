import 'package:foode/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class OnBoardingLocalDataSourceImpl extends OnboardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _preferences.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _preferences.getBool(kFirstTimerKey) ?? true;
    }  catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
