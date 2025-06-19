import 'package:foode/features/onboarding/data/data_sources/local/onboarding_local_data_sources.dart';
import 'package:foode/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:foode/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:foode/features/onboarding/domain/use_cases/cache_first_timer.dart';
import 'package:foode/features/onboarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:foode/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  //   Features Onboarding feature
  // Business Logic
  sl
    ..registerFactory(
      () =>
          OnboardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
    // Use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    // Repositories
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(sl()),
    )
    // Data sources
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()),
    )
    // External dependencies
    ..registerLazySingleton(() => prefs);
}
