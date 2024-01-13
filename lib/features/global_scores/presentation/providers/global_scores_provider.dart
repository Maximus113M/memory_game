import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/domain/use_cases/get_global_scores_use_case.dart';

import 'package:go_router/go_router.dart';

class GlobalScoresProvider with ChangeNotifier {
  final GetGlobalScoresStreamUseCase? getGlobalScoresStreamUseCase;
  List<GlobalScoreEntity> easyModeScoreList = [];
  List<GlobalScoreEntity> mediumModeScoreList = [];
  List<GlobalScoreEntity> hardModeScoreList = [];
  List<GlobalScoreEntity> currentScoreList = [];
  bool isLoadingGlobalScores = false;
  int gameMode = 1;

  GlobalScoresProvider({required this.getGlobalScoresStreamUseCase});

  void getGlobalScores(BuildContext context, int gameMode) async {
    isLoadingGlobalScores = true;
    notifyListeners();
    this.gameMode = gameMode;
    final result = await getGlobalScoresStreamUseCase!(gameMode);
    result.fold(
      (l) =>
          InAppNotification.serverFailure(context: context, message: l.message),
      (r) {
        if (r.isNotEmpty) {
          switch (gameMode) {
            case 1:
              easyModeScoreList = r;
              break;
            case 2:
              mediumModeScoreList = r;
              break;
            case 3:
              hardModeScoreList = r;
              break;
            default:
          }
        }
        selectScoreList();
        notifyListeners();
        GoRouter.of(context).push('/global-scores-view');
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    isLoadingGlobalScores = false;
    notifyListeners();
  }

  void selectScoreList() {
    switch (gameMode) {
      case 1:
        currentScoreList = easyModeScoreList;
        break;
      case 2:
        currentScoreList = mediumModeScoreList;
        break;
      case 3:
        currentScoreList = hardModeScoreList;
        break;
      default:
        currentScoreList = [];
    }
  }

  void goToScoresListView(BuildContext context, int gameDifficulty) {
    getGlobalScores(context, gameDifficulty);
  }
}
