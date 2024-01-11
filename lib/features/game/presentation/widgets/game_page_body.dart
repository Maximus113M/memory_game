import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/game/presentation/widgets/card_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';

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

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Column(
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5),
                itemCount: gameProvider.completedCardList.length,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                itemBuilder: (context, index) {
                  gameProvider.completedCardList[index].id = index;
                  gameProvider.currentCard =
                      gameProvider.completedCardList[index];
                  gameProvider.setColors();
                  return GestureDetector(
                    onTap: () {
                      if (gameProvider.isValidating ||
                          !gameProvider.isTimerOn) {
                        return;
                      }
                      gameProvider.currentCard =
                          gameProvider.completedCardList[index];

                      if (gameProvider.currentCard!.isSelected ||
                          gameProvider.currentCard!.isFound) {
                        return;
                      }

                      if (gameProvider.firstCard != null) {
                        gameProvider.secondCard = gameProvider.currentCard;
                        gameProvider.currentCard!.select();
                        gameProvider.validateMatching(context);
                      } else {
                        gameProvider.firstCard = gameProvider.currentCard;
                        gameProvider.currentCard!.select();
                      }
                      gameProvider.countTaps();
                      setState(() {});
                    },
                    child: gameProvider.isMemorizing ||
                            gameProvider.currentCard!.isSelected ||
                            gameProvider.currentCard!.isFound
                        ? CardBody(
                            icon: gameProvider.completedCardList[index].icon,
                            cardColor: gameProvider.cardBackColor,
                            iconColor: gameProvider.cardBackIconColor,
                          )
                        : const CardBody(),
                  );
                },
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
                  icon: gameProvider.isTimerOn
                      ? Icons.stop_circle_outlined
                      : Icons.not_started,
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
                  icon: Icons.restart_alt_outlined,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
