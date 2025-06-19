import 'package:foode/core/common/views/page_under_construction.dart';
import 'package:foode/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foode/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:foode/features/onboarding/presentation/views/onboarding_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen.routeName:
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageRouteBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageRouteBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    settings: settings,
    transitionsBuilder:
        (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
  );
}
