import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';

class MenuCard extends StatelessWidget {
  final int difficultyValue;
  final Color backgroundColor;
  final String difficultyName;

  const MenuCard({
    super.key,
    required this.difficultyValue,
    required this.backgroundColor,
    required this.difficultyName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(ScreenSize.width * 0.03, 0,
          ScreenSize.width * 0.03, ScreenSize.height * 0.02),
      color: backgroundColor,
      elevation: 10,
      shadowColor: AppColors.scoresCardShadow,
      shape: ContinuousRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(70),
          bottomRight: Radius.circular(100),
        ),
        side: BorderSide(
          color: AppColors.text.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                difficultyValue,
                (index) => const Icon(
                  Icons.star,
                  size: 40,
                  color: AppColors.contrast,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              difficultyName.toUpperCase(),
              style: FontStyles.heading11(AppColors.contrast),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Check out the best scores \nin $difficultyName!',
              style: FontStyles.body1(AppColors.contrast),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
