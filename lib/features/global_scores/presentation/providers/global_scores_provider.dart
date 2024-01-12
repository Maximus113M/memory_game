import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/domain/use_cases/get_global_scores_use_case.dart';

class GlobalScoresProvider with ChangeNotifier {
  final GetGlobalScoresStreamUseCase? getGlobalScoresStreamUseCase;
  List<GlobalScoreEntity> easyModeScoreList = [];
  List<GlobalScoreEntity> mediumModeScoreList = [];
  List<GlobalScoreEntity> hardModeScoreList = [];
  bool isLoadingGlobalScores = false;
  int gameMode = 1;

  GlobalScoresProvider({required this.getGlobalScoresStreamUseCase});

  void getGlobalScores(BuildContext context) async {
    isLoadingGlobalScores = true;
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
      },
    );
    notifyListeners();
    isLoadingGlobalScores = false;
  }

  List<GlobalScoreEntity> selectScoreList() {
    switch (gameMode) {
      case 1:
        return easyModeScoreList;
      case 2:
        return mediumModeScoreList;
      case 3:
        return hardModeScoreList;
      default:
        return [];
    }
  }
}
