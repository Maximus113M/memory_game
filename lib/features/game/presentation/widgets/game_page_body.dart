import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/features/game/presentation/widgets/card_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

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
                  crossAxisSpacing: 5,
                ),
                itemCount: gameProvider.completedCardList.length,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                itemBuilder: (context, index) {
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
                /*CustomFilledButtonIcon(
                  onPress: () {
                    var newGameStatistics = GameStatisticsModel(
                      attempts: 15,
                      gameMode: GameDifficulty.easy,
                      score: 2650,
                      time: '00:20',
                    );
                    gameProvider.scoreDbRegister(context, newGameStatistics);
                    gameProvider.scoreLocalRegister(context, newGameStatistics);
                  
                  },
                  text: '',
                  icon: Icons.restart_alt_outlined,
                ),*/
              ],
            ),
          ],
        );
      },
    );
  }
}
