import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';

import 'package:animate_do/animate_do.dart';

class SplashBody extends StatelessWidget {
  final SplashProvider splashProvider;
  const SplashBody({super.key, required this.splashProvider});

  @override
  Widget build(BuildContext context) {
    splashProvider.appInit(context);

    return Container(
      height: ScreenSize.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: ScreenSize.height * 0.2,
          ),
          BounceInDown(
            child: Flash(
              delay: const Duration(milliseconds: 1000),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Image.asset(AppAssets.brain2),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            child: const Text(
              'Memory Game',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
