import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GameDataSource {
  Future<bool> registerGameScore(GameStatisticsModel gameStatisticsModel);
  Future<bool> uploadGameScore(
      List<ScoresDataModel> scoreDataList, bool isMergeable);
}

class GameDataSourceImpl extends GameDataSource {
  final FirebaseFirestore db;

  GameDataSourceImpl({required this.db});

  @override
  Future<bool> registerGameScore(
      GameStatisticsModel gameStatisticsModel) async {
    try {
      final UserDataModel? userData = AuthService.userData;
      if (userData != null) {
        List<ScoresDataModel> scoresList = [];
        QuerySnapshot scoresHasData = await db
            .collection(Server.globalScores)
            .where('game_mode',
                isEqualTo: AppFunctions.getDifficultyValue(
                    gameStatisticsModel.gameMode))
            .limit(1)
            .get();

        if (scoresHasData.size > 0) {
          QuerySnapshot scoresDb = await db
              .collection(Server.globalScores)
              .where('score', isLessThan: gameStatisticsModel.score)
              .where('game_mode',
                  isEqualTo: AppFunctions.getDifficultyValue(
                      gameStatisticsModel.gameMode))
              .get();

          for (var doc in scoresDb.docs) {
            scoresList.add(
              ScoresDataModel.fromJson(doc),
            );
          }
          scoresList.sort((a, b) => a.rank.compareTo(b.rank));
        }
        bool isMergeable = false;
        ScoresDataModel scoreGameData = ScoresDataModel(
          userId: userData.id,
          userName: userData.name,
          attempts: gameStatisticsModel.attempts,
          rank: 1,
          score: gameStatisticsModel.score,
          time: gameStatisticsModel.time,
          date: AppFunctions.getDateFormated(),
          gameMode:
              AppFunctions.getDifficultyValue(gameStatisticsModel.gameMode),
        );

        if (scoresHasData.size > 0 && scoresList.isNotEmpty) {
          scoreGameData.rank = scoresList[0].rank;
          for (var scoreItem in scoresList) {
            scoreItem.incrementRank();
          }
          scoresList.insert(0, scoreGameData);
          scoresList.removeWhere((element) => element.rank > 10);
          isMergeable = true;
          await uploadGameScore(scoresList, isMergeable);
        } else {
          scoresList.add(scoreGameData);
          await uploadGameScore(scoresList, isMergeable);
        }
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      throw ServerException(
          message: 'An error occurred while registering the score game',
          type: ExceptionType.gameException);
    }
  }

  @override
  Future<bool> uploadGameScore(
      List<ScoresDataModel> scoreDataList, bool isMergeable) async {
    try {
      bool uploadDone = false;
      for (var scoreDataItem in scoreDataList) {
        db
            .collection(Server.globalScores)
            .doc("D${scoreDataItem.gameMode}-r${scoreDataItem.rank}")
            .set(
              scoreDataItem.scoresDataModelToJson(),
              SetOptions(
                merge: isMergeable,
              ),
            )
            .then((value) => uploadDone = true);
      }
      return uploadDone;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while uploading the score game',
          type: ExceptionType.gameException);
    }
  }
}
