import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';

import 'package:animate_do/animate_do.dart';

class MainLoading extends StatelessWidget {
  const MainLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: ScreenSize.height * 0.17, bottom: 12),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(AppAssets.cardsLoading),
          ),
        ),
        Flash(
          infinite: true,
          child: Text(
            '   LOADING...',
            style: FontStyles.heading6(AppColors.text),
          ),
        ),
      ],
    );
  }
}
