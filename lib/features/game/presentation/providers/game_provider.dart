import 'dart:async';
import 'package:flutter/material.dart';

import 'package:memory_game/features/game/domain/entities/card_entity.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/game/domain/entities/game_statistics_model.dart';
import 'package:memory_game/features/game/presentation/widgets/custom_game_dialog.dart';

import 'package:go_router/go_router.dart';

class GameProvider with ChangeNotifier {
  GameDifficulty? difficulty = GameDifficulty.easy;
  bool isMemorizing = false;
  int countdownLimit = 6;
  Duration duration = const Duration(seconds: 0);
  StreamSubscription<int>? timerSubscription;
  StreamSubscription<int>? countDownSubscription;
  bool isTimerOn = false;
  CardEntity? firstCard;
  CardEntity? secondCard;
  CardEntity? currentCard;
  int foundCardsCounter = 0;
  int counter = 0;
  int attemptsCounter = 0;
  List<CardEntity> completedCardList = [];
  bool isValidating = false;
  bool isGameEnd = false;
  Color? cardBackColor;
  Color? cardBackIconColor;

  GameProvider();

  void completeCardList() {
    completedCardList.addAll(cardList);
    completedCardList.shuffle();
  }

  void setColors() {
    if (currentCard!.isFound) {
      cardBackColor = Colors.yellow.shade600;
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

  void flipCard(BuildContext context, int index) {
    if (isValidating || !isTimerOn) {
      return;
    }
    currentCard = completedCardList[index];

    if (currentCard!.isSelected || currentCard!.isFound) {
      return;
    }
    if (firstCard != null) {
      secondCard = currentCard;
      currentCard!.select();
      validateMatching(context);
    } else {
      firstCard = currentCard;
      currentCard!.select();
    }
    countTaps();
    notifyListeners();
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
    gameEnd();
    resetGameValues();
  }

  void gameEnd() {
    timerSubscription?.cancel();
    isTimerOn = false;
    isGameEnd = true;
    notifyListeners();
  }

  void resetGameValues() {
    completedCardList
        .where((card) => card.isFound || card.isSelected)
        .forEach((foundCard) {
      foundCard.forget();
      foundCard.deselect();
    });
    resetCardsValue();
    if (isMemorizing) {
      countDownSubscription!.cancel();
      isMemorizing = false;
    }
    counter = 0;
    attemptsCounter = 0;
    foundCardsCounter = 0;
    duration = const Duration(seconds: 0);
    isGameEnd = false;
    completedCardList.clear();
    completeCardList();
  }

  void isWonGame(BuildContext context) {
    if (foundCardsCounter == completedCardList.length) {
      gameEnd();
      final timeBonusScore = timeBonus();
      final attemptsBonusScore = attemptsBonus();

      final gameStatisticsModel = GameStatisticsModel(
        attempts: attemptsCounter + 1,
        score: gameScore(
          attemptsBonus: attemptsBonusScore,
          timeBonus: timeBonusScore,
        ),
        time: getTimeString(),
        timeInSeconds: duration.inSeconds,
        timeBonus: timeBonusScore,
        attemptsBonus: attemptsBonusScore,
      );
      showModalDialog(context, gameStatisticsModel);
    }
  }

  void showModalDialog(
      BuildContext context, GameStatisticsModel gameStatisticsModel) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomGameDialog(gameStatisticsModel: gameStatisticsModel);
      },
    );
  }

  void startGame() {
    resetGameValues();
    isMemorizing = true;
    countDownSubscription = Stream.periodic(
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

  void goToHome(BuildContext context) {
    quitGame();
    GoRouter.of(context).pop();
  }

  int gameScore({required int timeBonus, required int attemptsBonus}) {
    int baseScore = 0;
    switch (difficulty) {
      case GameDifficulty.easy:
        baseScore =
            (3600 + (8 / attemptsCounter * 100 - duration.inSeconds * 8))
                .floor();
        break;
      case GameDifficulty.medium:
        baseScore =
            (3600 + (10 / attemptsCounter * 100 - duration.inSeconds * 12))
                .floor();
        break;
      case GameDifficulty.hard:
        baseScore =
            (3600 + (10 / attemptsCounter * 100 - duration.inSeconds * 14))
                .floor();
        break;
      default:
        baseScore = 0;
        break;
    }
    return baseScore + timeBonus + attemptsBonus;
  }

  int timeBonus() {
    int timeBonus = 0;
    switch (difficulty) {
      case GameDifficulty.easy:
        if (duration.inSeconds <= 15) {
          timeBonus += 16;
          if (duration.inSeconds <= 8) {
            timeBonus += 16;
          }
        }
        break;
      case GameDifficulty.medium:
        if (duration.inSeconds <= 15) {
          timeBonus += 30;
          if (duration.inSeconds <= 10) {
            timeBonus += 30;
          }
        }
        break;
      case GameDifficulty.hard:
        if (duration.inSeconds <= 15) {
          timeBonus += 35;
          if (duration.inSeconds <= 10) {
            timeBonus += 35;
          }
        }
        break;
      default:
        timeBonus = 0;
        break;
    }
    return timeBonus;
  }

  int attemptsBonus() {
    int attemptsBonus = 0;
    switch (difficulty) {
      case GameDifficulty.easy:
        if (attemptsCounter <= 12) {
          attemptsBonus += 8;
          if (attemptsCounter <= 10) {
            attemptsBonus += 8;
            if (attemptsCounter <= 8) {
              attemptsBonus += 8;
            }
          }
        }
        break;
      case GameDifficulty.medium:
        if (attemptsCounter <= 12) {
          attemptsBonus += 30;
          if (attemptsCounter <= 10) {
            attemptsBonus += 30;
          }
        }
        break;
      case GameDifficulty.hard:
        if (attemptsCounter <= 12) {
          attemptsBonus += 35;
          if (attemptsCounter <= 10) {
            attemptsBonus += 35;
          }
        }
        break;
      default:
        attemptsBonus = 0;
        break;
    }
    return attemptsBonus;
  }
}
