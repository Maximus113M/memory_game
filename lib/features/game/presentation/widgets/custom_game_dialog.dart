import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomGameDialog extends StatelessWidget {
  final GameStatisticsModel gameStatisticsModel;
  final Function() saveGameScore;

  const CustomGameDialog(
      {super.key,
      required this.gameStatisticsModel,
      required this.saveGameScore});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: ScreenSize.height * 0.68,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Well Done. You Won!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                width: ScreenSize.width * 0.58,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Game Summary',
                      style: FontStyles.subtitle1(AppColors.text),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Time: ${gameStatisticsModel.time}',
                      style: FontStyles.body0(AppColors.text),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Attempts: ${gameStatisticsModel.attempts}',
                      style: FontStyles.body0(AppColors.text),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Time Bonus: +${gameStatisticsModel.timeBonus}',
                      style: FontStyles.body0(AppColors.text),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Attempts Bonus: +${gameStatisticsModel.attemptsBonus}',
                      style: FontStyles.body0(AppColors.text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Score: ${gameStatisticsModel.score}',
                      style: FontStyles.subtitle1(AppColors.successText),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: ScreenSize.height * 0.25,
                width: ScreenSize.height * 0.25,
                child: Image.asset(
                  AppAssets.bmo,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: ScreenSize.height * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFilledButton(
                    text: 'Save',
                    horizontalPadding: ScreenSize.width * 0.1,
                    onPress: () => saveGameScore(),
                  ),
                  SizedBox(width: ScreenSize.width * 0.02),
                  CustomFilledButton(
                    text: 'Back',
                    horizontalPadding: ScreenSize.width * 0.1,
                    onPress: () => Navigator.pop(context),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
