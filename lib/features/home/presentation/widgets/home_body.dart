import 'package:flutter/material.dart';

import 'package:memory_game/config/utils/constanst/screen_size.dart';
import 'package:memory_game/features/home/presentation/widgets/card_body.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/config/shared/widgets/buttons/custom_filled_buttons.dart';

//import 'package:flip_card/flip_card.dart';
//import 'package:flip_card/flip_card_controller.dart';

class HomeBody extends StatelessWidget {
  final HomeProvider homeProvider;

  const HomeBody({super.key, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    //final cardController = FlipCardController();
    if (homeProvider.completedCardList.isEmpty) {
      homeProvider.completeCardList();
    }

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Column(
          children: [
            SizedBox(
              height: ScreenSize.height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.watch_later),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(homeProvider.getTimeString()),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 25),
              child: Text(
                'Attempts: ${homeProvider.attemptsCounter}',
                style: const TextStyle(fontSize: 20),
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
                itemCount: homeProvider.completedCardList.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  homeProvider.completedCardList[index].id = index;
                  homeProvider.currentCard =
                      homeProvider.completedCardList[index];
                  homeProvider.setColors();
                  return GestureDetector(
                    onTap: () {
                      if (homeProvider.isValidating ||
                          !homeProvider.isTimerOn) {
                        return;
                      }
                      homeProvider.currentCard =
                          homeProvider.completedCardList[index];

                      if (homeProvider.currentCard!.isSelected &&
                          homeProvider.currentCard!.isFound) {
                        return;
                      }

                      if (homeProvider.firstCard != null) {
                        homeProvider.secondCard = homeProvider.currentCard;
                        homeProvider.currentCard!.select();
                        homeProvider.validateMatching(context);
                      } else {
                        homeProvider.firstCard = homeProvider.currentCard;
                        homeProvider.currentCard!.select();
                      }
                      homeProvider.countTaps();
                      setState(() {});
                    },
                    child: homeProvider.isMemorizing ||
                            homeProvider.currentCard!.isSelected ||
                            homeProvider.currentCard!.isFound
                        ? CardBody(
                            icon: homeProvider.completedCardList[index].icon,
                            cardColor: homeProvider.cardBackColor,
                            iconColor: homeProvider.cardBackIconColor,
                          )
                        : const CardBody(),
                  );
                },
              ),
            ),
            /*const SizedBox(
              height: 10,
            ),*/
            CustomFilledButton(
              onPress: () => homeProvider.showModalDialog(context),
              text: 'Dialog',
            ),
            FilledButton.icon(
              onPressed: () {
                homeProvider.isTimerOn
                    ? homeProvider.stopGame()
                    : homeProvider.startGame();
              },
              icon: Icon(
                homeProvider.isTimerOn
                    ? Icons.pause_circle_filled
                    : Icons.not_started,
                size: 30,
              ),
              label: Text(
                homeProvider.isTimerOn ? 'Stop' : 'Start',
                style: const TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.black),
                shape: MaterialStatePropertyAll(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
