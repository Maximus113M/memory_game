import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/game/presentation/widgets/card_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

//import 'package:flip_card/flip_card.dart';
//import 'package:flip_card/flip_card_controller.dart';

class GamePageBody extends StatelessWidget {
  final GameProvider gameProvider;

  const GamePageBody({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    //final cardController = FlipCardController();
    if (gameProvider.completedCardList.isEmpty) {
      gameProvider.completeCardList();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              'Attempts: ${gameProvider.attemptsCounter}',
              style: FontStyles.subtitle1(AppColors.text),
            ),
          ),
          SizedBox(
            height: ScreenSize.height * 0.72,
            child: GridView(
              padding: EdgeInsets.symmetric(
                horizontal: 13,
                vertical: (gameProvider.currentGameMode == GameDifficulty.easy)
                    ? ScreenSize.height * 0.05
                    : 0,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: gameProvider.gridViewAspectRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              children: List.generate(
                gameProvider.completedCardList.length,
                (index) {
                  gameProvider.completedCardList[index].id = index;
                  gameProvider.currentCard =
                      gameProvider.completedCardList[index];
                  gameProvider.setColors();
                  return GestureDetector(
                    onTap: () {
                      gameProvider.flipCard(context, index);
                    },
                    child: gameProvider.isMemorizing ||
                            gameProvider.currentCard!.isSelected ||
                            gameProvider.currentCard!.isFound
                        ? Bounce(
                            animate: gameProvider.isFound &&
                                gameProvider.currentCard!.isSelected,
                            duration: const Duration(milliseconds: 800),
                            child: CardBody(
                              icon: gameProvider.completedCardList[index].icon,
                              cardColor: gameProvider.cardBackColor,
                              iconColor: gameProvider.cardBackIconColor,
                            ),
                          )
                        : const CardBody(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFilledButtonIcon(
                onPress: () {
                  if (gameProvider.isMemorizing) return;
                  gameProvider.isTimerOn
                      ? gameProvider.quitGame()
                      : gameProvider.startGame();
                },
                text: gameProvider.isTimerOn ? 'Quit' : 'Start',
                icon: gameProvider.isTimerOn ? Icons.block : Icons.bolt,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomFilledButtonIcon(
                onPress: () {
                  if (gameProvider.isMemorizing) return;
                  gameProvider.quitGame();
                  gameProvider.startGame();
                },
                text: 'Retry',
                icon: Icons.wifi_protected_setup_sharp,
              ),
              /* CustomFilledButtonIcon(
                onPress: () {
                  const currentGameMode = GameDifficulty.hard;
                  const attempts = 10;
                  const time = Duration(seconds: 10);
                  final timeBonusScore = AppFunctions.getTimeBonus(
                      difficulty: currentGameMode, duration: time);
                  final attemptsBonusScore = AppFunctions.getAttemptsBonus(
                      difficulty: currentGameMode, attemptsCounter: attempts);
                  int baseScore = AppFunctions.getBaseGameScore(
                    countdownTime: 3,
                    difficulty: currentGameMode,
                    attemptsCounter: attempts,
                    time: time,
                  );

                  var total = baseScore + timeBonusScore + attemptsBonusScore;
                  var newGameStatistics = GameStatisticsModel(
                    attempts: attempts,
                    gameMode: currentGameMode,
                    score: total.toInt(),
                    time: '${time.inSeconds}',
                  );
                  gameProvider.showEndGameDialog(context, newGameStatistics);
                  gameProvider.scoreDbRegister(context, newGameStatistics);
                  gameProvider.scoreLocalRegister(context, newGameStatistics);
                },
                text: '',
                icon: Icons.restart_alt_outlined,
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
