import 'dart:async';
import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/services/audio_service.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';
import 'package:memory_game/features/game/domain/entities/card_entity.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/features/game/presentation/widgets/custom_game_dialog.dart';
import 'package:memory_game/features/game/presentation/widgets/save_game_score_dialog.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_db_register_use_case.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_local_register_use_case.dart';

import 'package:go_router/go_router.dart';

class GameProvider with ChangeNotifier {
  final ScoreDbRegisterUseCase? scoreDbRegisterUseCase;
  final ScoreLocalRegisterUseCase? scoreLocalRegisterUseCase;
  GameDifficulty currentGameMode = GameDifficulty.easy;
  bool isMemorizing = false;
  int countdownLimit = 5;
  Duration duration = const Duration(seconds: 0);
  StreamSubscription<int>? timerSubscription;
  StreamSubscription<int>? countDownSubscription;
  bool isTimerOn = false;
  CardEntity? firstCard;
  CardEntity? secondCard;
  CardEntity? currentCard;
  int foundCardsCounter = 0;
  int attemptsCounter = 0;
  List<CardEntity> completedCardList = [];
  bool isValidating = false;
  bool isGameEnd = false;
  bool isCloudEnable = false;
  bool isFound = false;
  Color? cardBackColor;
  Color? cardBackIconColor;
  double gridViewAspectRatio = 1;
  String nameRecord = 'New Game Score';
  bool isSoundReady = false;

  GameProvider({
    required this.scoreDbRegisterUseCase,
    required this.scoreLocalRegisterUseCase,
  });

  void initGameSettings(UserSettingsModel userSettings) {
    currentGameMode = userSettings.gameMode;
    countdownLimit = userSettings.memorizingTime;
    isCloudEnable = userSettings.isCloudEnabled;
  }

  void getGameMode(GameDifficulty gameDifficulty) {
    completedCardList.clear();
    currentGameMode = gameDifficulty;
  }

  void getCountDownTime(int time) {
    countdownLimit = time;
  }

  void cloudEnable(bool value) {
    isCloudEnable = value;
  }

  void completeCardList() {
    completedCardList.addAll(CardEntity.baseCardList);
    switch (currentGameMode) {
      case GameDifficulty.easy:
        gridViewAspectRatio = 0.6;
        break;
      case GameDifficulty.medium:
        gridViewAspectRatio = 0.65;
        completedCardList.addAll(CardEntity.mediumCardList);
        break;
      case GameDifficulty.hard:
        gridViewAspectRatio = 0.81;
        completedCardList.addAll(CardEntity.mediumCardList);
        completedCardList.addAll(CardEntity.hardCardList);
        break;
      default:
        break;
    }
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

  void setNameRecord(String name) {
    nameRecord = name;
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

    isFound = false;
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
    notifyListeners();
  }

  void validateMatching(BuildContext context) async {
    isValidating = true;
    attemptsCounter += 1;
    if (firstCard!.value == secondCard!.value) {
      AudioService().playFoundSound();
      firstCard!.found();
      secondCard!.found();
      isFound = true;
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

  void quitGame() {
    gameEnd();
    resetGameValues();
    notifyListeners();
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
    attemptsCounter = 0;
    foundCardsCounter = 0;
    duration = const Duration(seconds: 0);
    isGameEnd = false;
    nameRecord = 'New Game Score';
    completedCardList.clear();
    completeCardList();
  }

  void isWonGame(BuildContext context) async {
    if (foundCardsCounter == completedCardList.length) {
      AudioService().playWinningSound();
      gameEnd();
      final timeBonusScore = AppFunctions.getTimeBonus(
          difficulty: currentGameMode, duration: duration);
      final attemptsBonusScore = AppFunctions.getAttemptsBonus(
          difficulty: currentGameMode, attemptsCounter: attemptsCounter);

      final newGameStatistics = GameStatisticsModel(
        attempts: attemptsCounter,
        score: gameScore(
            attemptsBonus: attemptsBonusScore, timeBonus: timeBonusScore),
        time: getTimeString(),
        timeBonus: timeBonusScore,
        attemptsBonus: attemptsBonusScore,
        gameMode: currentGameMode,
      );
      showEndGameDialog(context, newGameStatistics);
    }
  }

  void scoreRegister(
      BuildContext context, GameStatisticsModel newGameStatistics) {
    if (newGameStatistics.score > 0) {
      if (isCloudEnable) scoreDbRegister(context, newGameStatistics);
      if (nameRecord != 'New Game Score') {
        newGameStatistics.recordName = nameRecord;
      }
      scoreLocalRegister(context, newGameStatistics);
    }
  }

  void showEndGameDialog(
      BuildContext context, GameStatisticsModel gameStatisticsModel) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomGameDialog(
            gameStatisticsModel: gameStatisticsModel,
            saveGameScore: () {
              context.pop();
              showDialog(
                context: context,
                builder: (context) => SaveGameScoreDialog(
                  saveGameScore: () {
                    scoreRegister(context, gameStatisticsModel);
                    context.pop();
                  },
                  setNameRecord: (value) => setNameRecord(value),
                  hideText: nameRecord,
                ),
              );
            });
      },
    );
  }

  void startGame() {
    resetGameValues();
    isMemorizing = true;
    countDownSubscription = Stream.periodic(
            const Duration(seconds: 1), (second) => countdownLimit - second)
        .take(countdownLimit + 1)
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

  void goToHome(BuildContext context) async {
    quitGame();
    GoRouter.of(context).pop();
  }

  int gameScore({required int timeBonus, required int attemptsBonus}) {
    int baseScore = AppFunctions.getBaseGameScore(
      countdownTime: countdownLimit,
      difficulty: currentGameMode,
      attemptsCounter: attemptsCounter,
      time: duration,
    );

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
