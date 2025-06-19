import 'package:flutter/material.dart';
import 'package:foode/core/common/widgets/gradient_background.dart';
import 'package:foode/generated/assets.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: Assets.logoLoginLogo,
        child: Center(child: Lottie.asset(Assets.lottiePageUnderConstruction)),
      ),
    );
  }
}
