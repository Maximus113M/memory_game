import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';
import 'package:memory_game/features/game/domain/entities/game_statistics_model.dart';

class CustomGameDialog extends StatelessWidget {
  final GameStatisticsModel gameStatisticsModel;

  const CustomGameDialog({super.key, required this.gameStatisticsModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: ScreenSize.height * 0.66,
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
              const SizedBox(
                height: 20,
              ),
              CustomFilledButton(
                text: 'Ok',
                onPress: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
