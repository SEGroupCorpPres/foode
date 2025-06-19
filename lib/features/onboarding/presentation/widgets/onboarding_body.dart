import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foode/core/extensions/context_extensions.dart';
import 'package:foode/core/res/colours.dart';
import 'package:foode/core/res/fonts.dart';
import 'package:foode/features/onboarding/domain/page_content.dart';
import 'package:foode/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image, height: context.height * .4),
        SizedBox(height: context.height * .03),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: Fonts.sourceSansPro,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.height * .02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(height: context.height * .05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  backgroundColor: Colours.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                   context.read<OnboardingCubit>().cacheFirstTimer();
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: Fonts.sourceSansPro,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
