import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/global_scores/domain/use_cases/get_global_scores_use_case.dart';

import 'package:go_router/go_router.dart';

class GlobalScoresProvider with ChangeNotifier {
  final GetGlobalScoresUseCase? getGlobalScoresUseCase;
  List<ScoresDataModel> currentScoreList = [];
  bool isLoadingGlobalScores = false;
  int gameMode = 1;

  GlobalScoresProvider({required this.getGlobalScoresUseCase});

  void getGlobalScores(BuildContext context, int gameMode) async {
    isLoadingGlobalScores = true;
    notifyListeners();
    this.gameMode = gameMode;
    final result = await getGlobalScoresUseCase!(gameMode);
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
        GoRouter.of(context).push('/global-scores-view');
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    isLoadingGlobalScores = false;
    notifyListeners();
  }

  void goToScoresListView(BuildContext context, int gameDifficulty) {
    getGlobalScores(context, gameDifficulty);
  }
}
