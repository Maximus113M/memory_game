import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/game/presentation/widgets/game_page_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class GamePage extends StatelessWidget {
  static const name = '/game';
  final GameProvider gameProvider;

  const GamePage({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.text,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          onPressed: () => gameProvider.goToHome(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.contrast,
          ),
        ),
        title: Text(
          'Memory Game',
          style: FontStyles.subtitle2(AppColors.contrast),
        ),
        actions: [
          Flash(
            animate: gameProvider.isMemorizing || gameProvider.isGameEnd,
            infinite: true,
            duration: const Duration(milliseconds: 2000),
            child: Row(
              children: [
                Roulette(
                  animate: gameProvider.isTimerOn,
                  duration: const Duration(milliseconds: 4000),
                  child: Icon(
                    Icons.hourglass_bottom,
                    color: AppColors.contrast,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  child: Text(
                    gameProvider.getTimeString(),
                    style: FontStyles.body1(AppColors.contrast),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: GamePageBody(
        gameProvider: Provider.of<GameProvider>(context),
      ),
    );
  }
}
