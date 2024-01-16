import 'package:flutter/material.dart';
import 'package:memory_game/core/helpers/use_case.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/clear_local_scores_use_case.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/get_local_scores_use_case.dart';

import 'package:go_router/go_router.dart';

class LocalScoresProvider with ChangeNotifier {
  final GetLocalScoresUseCase? getLocalScoresUseCase;
  final ClearLocalScoresUseCase? clearLocalScoreUseCase;
  List<ScoresDataModel> currentScoreList = [];
  bool isLoadingLocalScores = false;
  int gameMode = 1;

  LocalScoresProvider({
    required this.getLocalScoresUseCase,
    required this.clearLocalScoreUseCase,
  });

  void getLocalScores(BuildContext context, int gameMode) async {
    isLoadingLocalScores = true;
    notifyListeners();
    this.gameMode = gameMode;
    final result = await getLocalScoresUseCase!(gameMode);
    result.fold(
      (l) =>
          InAppNotification.serverFailure(context: context, message: l.message),
      (r) {
        switch (gameMode) {
          case 1:
            currentScoreList = r;
            break;
          case 2:
            currentScoreList = r;
            break;
          case 3:
            currentScoreList = r;
            break;
          default:
        }

        notifyListeners();
        GoRouter.of(context).push('/local-scores-view');
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    isLoadingLocalScores = false;
    notifyListeners();
  }

  void clearLocalScores() async {
    await clearLocalScoreUseCase!(NoParams());
    currentScoreList = [];
    notifyListeners();
  }

  void goToScoresListView(BuildContext context, int gameDifficulty) {
    getLocalScores(context, gameDifficulty);
  }
}
