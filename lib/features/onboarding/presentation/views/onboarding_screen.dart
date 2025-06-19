import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foode/core/common/views/loading_view.dart';
import 'package:foode/core/common/widgets/gradient_background.dart';
import 'package:foode/features/onboarding/domain/page_content.dart';
import 'package:foode/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:foode/features/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:foode/generated/assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: Assets.logoLoginLogo,
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer || state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnboardingBody(
                      pageContent: PageContent.first(),
                    ),
                    OnboardingBody(
                      pageContent: PageContent.second(),
                    ),
                    OnboardingBody(
                      pageContent: PageContent.third(),
                    ),
                  ],
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: SmoothPageIndicator(
                //     controller: pageController,
                //     count: 3,
                //     onDotClicked: (index) => pageController.animateToPage(
                //       index,
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.easeInOut,
                //     ),
                //     effect: const WormEffect(
                //       dotHeight: 10,
                //       dotWidth: 10,
                //       activeDotColor: Colours.primaryColor,
                //       dotColor: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
