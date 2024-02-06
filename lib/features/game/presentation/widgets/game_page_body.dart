import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/game/presentation/widgets/card_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

import 'package:flip_card/flip_card.dart';
import 'package:animate_do/animate_do.dart';

class GamePageBody extends StatelessWidget {
  final GameProvider gameProvider;

  const GamePageBody({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
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

                  if (gameProvider
                          .completedCardList[index].cardKey.currentState !=
                      null) {
                    if (gameProvider.showingCards &&
                        !gameProvider.isMemorizing) {
                      gameProvider
                          .completedCardList[index].cardKey.currentState!
                          .toggleCard();
                      if (gameProvider.completedCardList.length - 1 == index) {
                        gameProvider.showingCards = false;
                      }
                    }
                  }

                  if (gameProvider.isMemorizing && !gameProvider.showingCards) {
                    gameProvider.completedCardList[index].cardKey.currentState!
                        .toggleCard();
                    if (gameProvider.completedCardList.length - 1 == index) {
                      gameProvider.showingCards = true;
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      gameProvider.toggleCurrentCard(index);
                    },
                    child: FlipCard(
                      key: gameProvider.completedCardList[index].cardKey,
                      flipOnTouch: false,
                      speed: 150,
                      onFlipDone: (isFront) {
                        if (isFront && !gameProvider.isMemorizing) {
                          gameProvider.flipCardDone(context);
                        }
                      },
                      front: const CardBody(),
                      back: Bounce(
                        animate: gameProvider
                                .completedCardList[index].isFound &&
                            gameProvider.completedCardList[index].isSelected,
                        duration: const Duration(milliseconds: 800),
                        child: CardBody(
                          icon: gameProvider.completedCardList[index].icon,
                          isFound:
                              gameProvider.completedCardList[index].isFound,
                        ),
                      ),
                    ),
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
                  if (gameProvider.isTimerOn) {
                    gameProvider.quitGame();
                    return;
                  }
                  gameProvider.startGame();
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
              //TODO PRUEBAS
              /*CustomFilledButtonIcon(
                onPress: () {
                  const currentGameMode = GameDifficulty.easy;
                  const attempts = 6;
                  const time = Duration(seconds: 59);
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
                    attemptsBonus: attemptsBonusScore,
                    timeBonus: timeBonusScore,
                  );
                  gameProvider.showEndGameDialog(context, newGameStatistics);
                  //gameProvider.scoreDbRegister(context, newGameStatistics);
                  //gameProvider.scoreLocalRegister(context, newGameStatistics);
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
