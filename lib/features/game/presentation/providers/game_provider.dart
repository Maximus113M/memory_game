import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

import 'package:memory_game/features/game/domain/entities/card_entity.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_db_register_use_case.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_local_register_use_case.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/game/presentation/widgets/custom_game_dialog.dart';

import 'package:go_router/go_router.dart';

class GameProvider with ChangeNotifier {
  final ScoreDbRegisterUseCase? scoreDbRegisterUseCase;
  final ScoreLocalRegisterUseCase? scoreLocalRegisterUseCase;
  GameDifficulty difficulty = GameDifficulty.easy;
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

  GameProvider({
    required this.scoreDbRegisterUseCase,
    required this.scoreLocalRegisterUseCase,
  });

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

      final timeBonusScore =
          AppFunctions.getTimeBonus(difficulty: difficulty, duration: duration);
      final attemptsBonusScore = AppFunctions.getAttemptsBonus(
          difficulty: difficulty, attemptsCounter: attemptsCounter + 1);

      final newGameStatistics = GameStatisticsModel(
        attempts: attemptsCounter + 1,
        score: gameScore(
            attemptsBonus: attemptsBonusScore, timeBonus: timeBonusScore),
        time: getTimeString(),
        timeBonus: timeBonusScore,
        attemptsBonus: attemptsBonusScore,
        gameMode: difficulty,
      );
      if (newGameStatistics.score > 0) {
        //scoreDbRegister(context, newGameStatistics);
        //print('Registration');
        scoreLocalRegister(context, newGameStatistics);
      }
      showModalDialog(context, newGameStatistics);
    }
  }

  void showModalDialog(
      BuildContext context, GameStatisticsModel gameStatisticsModel) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomGameDialog(
          gameStatisticsModel: gameStatisticsModel,
          saveGameScore: () => showDialog(
            context: context,
            builder: (context) => CustomGameDialog(
              gameStatisticsModel: gameStatisticsModel,
              saveGameScore: () => null,
            ),
          ),
        );
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
    int baseScore = AppFunctions.getBaseGameScore(
        difficulty: difficulty,
        attemptsCounter: attemptsCounter,
        duration: duration);

    return baseScore + timeBonus + attemptsBonus;
  }

  void scoreDbRegister(
      BuildContext context, GameStatisticsModel gameStatistics) async {
    final result = await scoreDbRegisterUseCase!(gameStatistics);

    result.fold((l) {
      InAppNotification.serverFailure(context: context, message: l.message);
    }, (r) => print(r));
  }

  void scoreLocalRegister(
      BuildContext context, GameStatisticsModel gameStatistics) async {
    final result = await scoreLocalRegisterUseCase!(gameStatistics);

    result.fold((l) {
      InAppNotification.serverFailure(context: context, message: l.message);
    }, (r) => print(r));
  }
}
