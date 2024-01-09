import 'dart:async';
import 'package:flutter/material.dart';

import 'package:memory_game/features/home/domain/entities/card_entity.dart';
import 'package:memory_game/features/home/presentation/widgets/custom_dialog.dart';

class HomeProvider with ChangeNotifier {
  bool isMemorizing = false;
  int countdownLimit = 6;
  Duration duration = const Duration(seconds: 0);
  StreamSubscription<int>? timerSubscription;
  bool isTimerOn = false;
  CardEntity? firstCard;
  CardEntity? secondCard;
  CardEntity? currentCard;
  int foundCardsCounter = 0;
  int counter = 0;
  int attemptsCounter = 0;
  List<CardEntity> completedCardList = [];
  bool isValidating = false;
  Color? cardBackColor;
  Color? cardBackIconColor;

  HomeProvider();

  void completeCardList() {
    completedCardList.addAll(cardList);
    completedCardList.shuffle();
  }

  void setColors() {
    if (currentCard!.isFound) {
      cardBackColor = Colors.yellow.shade700;
      cardBackIconColor = Colors.white;
      return;
    }
    cardBackColor = Colors.white;
    cardBackIconColor = Colors.black;
  }

  void resetCardsValue() {
    firstCard?.deselect();
    secondCard?.deselect();
    firstCard = null;
    secondCard = null;
  }

  void validateMatching(BuildContext context) async {
    isValidating = true;
    if (firstCard!.value == secondCard!.value) {
      firstCard!.found();
      secondCard!.found();
      foundCardsCounter += 2;
      isWonGame(context);
      await Future.delayed(const Duration(milliseconds: 250));
    } else {
      await Future.delayed(const Duration(milliseconds: 600));
    }
    resetCardsValue();
    isValidating = false;

    notifyListeners();
  }

  void countTaps() {
    counter += 1;
    if (counter % 2 == 0) {
      attemptsCounter += 1;
    }
  }

  void quitGame() {
    stopGame();
    resetGame();
  }

  void stopGame() {
    timerSubscription?.cancel();
    isTimerOn = false;
    notifyListeners();
  }

  void resetGame() {
    completedCardList
        .where((card) => card.isFound || card.isSelected)
        .forEach((foundCard) {
      foundCard.forget();
      foundCard.deselect();
    });
    resetCardsValue();
    counter = 0;
    attemptsCounter = 0;
    foundCardsCounter = 0;
    completedCardList.clear();
    completeCardList();
  }

  void isWonGame(BuildContext context) {
    if (foundCardsCounter == completedCardList.length) {
      stopGame();
      showModalDialog(context);
    }
  }

  void showModalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(attempts: attemptsCounter);
      },
    );
  }

  void startGame() {
    resetGame();
    isMemorizing = true;
    Stream.periodic(
            const Duration(seconds: 1), (second) => countdownLimit - second - 1)
        .take(6)
        .listen((timeLeft) {
      if (timeLeft == 0) {
        isMemorizing = false;
        startTimer();
      }
      duration = Duration(seconds: timeLeft);
      notifyListeners();
    });
  }

  void startTimer() {
    if (isTimerOn) return;
    timerSubscription = Stream.periodic(const Duration(seconds: 1), (value) {
      return value + 1;
    }).listen((value) {
      duration = Duration(seconds: value);
      notifyListeners();
    });
    isTimerOn = true;
  }

  String getTimeString() {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}
