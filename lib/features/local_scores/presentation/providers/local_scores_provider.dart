import 'package:flutter/material.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/widgets/dialogs/custom_confirmation_dialog.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/core/shared/widgets/dialogs/imersive_dialog/content_bodies.dart';
import 'package:memory_game/core/shared/widgets/dialogs/imersive_dialog/custom_imersive_dialog.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/delete_local_score_use_case.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/clear_local_scores_by_game_mode_use_case.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/get_local_scores_use_case.dart';

import 'package:go_router/go_router.dart';

class LocalScoresProvider with ChangeNotifier {
  final GetLocalScoresUseCase? getLocalScoresUseCase;
  final ClearLocalScoresByGameModeUseCase? clearLocalScoreByGameModeUseCase;
  final DeleteLocalScoreUseCase? deleteLocalScoreUseCase;

  List<ScoresDataModel> currentScoreList = [];
  bool isLoadingLocalScores = false;
  int gameMode = 1;
  bool isCompleteCleaning = false;
  int? selectedIndex;

  LocalScoresProvider({
    required this.getLocalScoresUseCase,
    required this.clearLocalScoreByGameModeUseCase,
    required this.deleteLocalScoreUseCase,
  });

  void getLocalScores(BuildContext context, int gameMode) async {
    isLoadingLocalScores = true;
    isCompleteCleaning = false;
    notifyListeners();
    this.gameMode = gameMode;
    final result = await getLocalScoresUseCase!(gameMode);
    result.fold(
      (l) =>
          InAppNotification.serverFailure(context: context, message: l.message),
      (r) {
        currentScoreList = r;

        notifyListeners();
        GoRouter.of(context).push('/local-scores-view');
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    isLoadingLocalScores = false;
    notifyListeners();
  }

  void showDeleteScoresImersiveDialog(BuildContext context) {
    if (!isCompleteCleaning &&
        currentScoreList.isEmpty &&
        !isLoadingLocalScores) {
      InAppNotification.showAppNotification(
        context: context,
        title: 'Nothing around here!',
        message: 'No record has been found...',
        type: NotificationType.success,
        duration: 2,
      );
      isCompleteCleaning = true;
      return;
    }
    if (currentScoreList.isEmpty) return;

    showDialog(
      barrierColor: AppColors.text.withOpacity(0.95),
      context: context,
      builder: (context) => CustomImersiveDialog(
        disableOptionTitle: 'Cancel',
        okOptionTitle: 'Continue',
        contentBody: basicMessageBody(
            'Remember that you will not be able to recover the score records when they',
            'have been deleted, only continue if you are sure, do you want to continue?',
            Icons.warning),
        disableOption: () {
          context.pop();
        },
        okOption: () {
          context.pop();
          clearCurrentLocalScores(context);
        },
      ),
    );
  }

  void clearCurrentLocalScores(BuildContext context) async {
    final result = await clearLocalScoreByGameModeUseCase!(gameMode);
    result.fold(
        (l) => InAppNotification.serverFailure(
              context: context,
              message: l.message,
            ), (r) {
      if (r) {
        InAppNotification.showAppNotification(
          context: context,
          title: 'Sucessfully deleted',
          message: 'All score records have been deleted',
          type: NotificationType.success,
          duration: 3,
        );
        currentScoreList.clear();
      } else {
        //TODO MAY TO GAME MODE WITHOUT SIGN IN
      }
    });
    notifyListeners();
  }

  showDeleteScoresDialog(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();
    ScoresDataModel selectedScore = currentScoreList[index];
    showDialog(
        barrierDismissible: false,
        barrierColor: AppColors.text.withOpacity(0.7),
        context: context,
        builder: (context) => CustomConfirmationDialog(
              title: 'Hey ${AuthService.userData!.name}!',
              message: 'Do you want delete it?\n"${selectedScore.userName}"',
              mainAction: () => deleteLocalScore(context, index, selectedScore),
              secundaryAction: () {
                selectedIndex = null;
                context.pop();
                notifyListeners();
              },
            ));
  }

  void deleteLocalScore(
      BuildContext context, int index, ScoresDataModel selectedScore) async {
    context.pop();
    final result = await deleteLocalScoreUseCase!(selectedScore);
    result.fold(
        (l) => InAppNotification.serverFailure(
              context: context,
              message: l.message,
            ), (r) {
      if (r) {
        InAppNotification.showAppNotification(
          context: context,
          title: 'Sucessfully deleted',
          message: 'The selected score record has been deleted',
          type: NotificationType.success,
          duration: 3,
        );
        currentScoreList.removeAt(index);
      } else {
        //TODO MAY TO GAME MODE WITHOUT SIGN IN
      }
    });
    selectedIndex = null;
    notifyListeners();
  }

  void goToScoresListView(BuildContext context, int gameDifficulty) {
    getLocalScores(context, gameDifficulty);
  }
}
