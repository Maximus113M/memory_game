import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GameDataSource {
  Future<bool> gameScoreDbRegister(GameStatisticsModel gameStatistics);
  Future uploadGameScoreToDb(
      List<ScoresDataModel> scoreDataList, bool isMergeable);
  Future<bool> gameScoreLocalRegister(GameStatisticsModel gameStatistics);
  Future<bool> uploadGameScoreToLocal(List<ScoresDataModel> scoreDataList);
}

class GameDataSourceImpl extends GameDataSource {
  final FirebaseFirestore db;
  late Future<Isar> isarIntance;

  GameDataSourceImpl({required this.db}) {
    isarIntance = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ScoresDataModelSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> gameScoreDbRegister(GameStatisticsModel gameStatistics) async {
    try {
      final UserDataModel? userData = AuthService.userData;
      if (userData != null) {
        List<ScoresDataModel> scoresList = [];
        ScoresDataModel? lastScoreRecord;

        QuerySnapshot scoresHasData = await db
            .collection(Server.globalScores)
            .where('game_mode',
                isEqualTo:
                    AppFunctions.getDifficultyValue(gameStatistics.gameMode))
            .orderBy('score', descending: true)
            .limitToLast(1)
            .get();

        if (scoresHasData.size > 0) {
          lastScoreRecord = ScoresDataModel.fromJson(scoresHasData.docs[0]);
          QuerySnapshot scoresDb = await db
              .collection(Server.globalScores)
              .where('score', isLessThan: gameStatistics.score)
              .where('game_mode',
                  isEqualTo:
                      AppFunctions.getDifficultyValue(gameStatistics.gameMode))
              .get();

          for (var doc in scoresDb.docs) {
            scoresList.add(
              ScoresDataModel.fromJson(doc),
            );
          }
        }
        bool isMergeable = false;
        ScoresDataModel newScoreGameData = ScoresDataModel(
          userId: userData.id,
          userName: userData.name,
          attempts: gameStatistics.attempts,
          score: gameStatistics.score,
          time: gameStatistics.time,
          ranking: 1,
          date: DateTime.timestamp(),
          gameMode: AppFunctions.getDifficultyValue(gameStatistics.gameMode),
        );

        if (scoresList.isNotEmpty) {
          scoresList.sort((a, b) => b.score.compareTo(a.score));
          newScoreGameData.ranking = scoresList[0].ranking;
          for (var scoreItem in scoresList) {
            scoreItem.ranking = scoreItem.ranking + 1;
          }
          scoresList.insert(0, newScoreGameData);
          scoresList.removeWhere((element) => element.ranking > 10);
          isMergeable = true;
          await uploadGameScoreToDb(scoresList, isMergeable);
        } else {
          if (lastScoreRecord != null) {
            newScoreGameData.ranking = lastScoreRecord.ranking + 1;
          }
          if (newScoreGameData.ranking <= 10) {
            scoresList.add(newScoreGameData);
            await uploadGameScoreToDb(scoresList, isMergeable);
          }
        }
        return true;
      }

      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while registering the score game',
          type: ExceptionType.gameException);
    }
  }

  @override
  Future uploadGameScoreToDb(
      List<ScoresDataModel> scoreDataList, bool isMergeable) async {
    try {
      bool uploadDone = false;
      for (var scoreDataItem in scoreDataList) {
        db
            .collection(Server.globalScores)
            .doc("D${scoreDataItem.gameMode}-r${scoreDataItem.ranking}")
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
          message:
              'An error has occurred when uploading the game score to the cloud',
          type: ExceptionType.gameException);
    }
  }

  @override
  Future<bool> gameScoreLocalRegister(
      GameStatisticsModel gameStatistics) async {
    try {
      List<ScoresDataModel> scoreList = [];
      final Isar isarDb = await isarIntance;
      final int lastIndex = isarDb.scoresDataModels.countSync();
      ScoresDataModel? lastScoreItem;

      if (lastIndex > 0) {
        lastScoreItem = await isarDb.scoresDataModels
            .filter()
            .gameModeEqualTo(
                AppFunctions.getDifficultyValue(gameStatistics.gameMode))
            .sortByScoreDesc()
            .findFirst();

        if (lastScoreItem != null) {
          scoreList = await isarDb.scoresDataModels
              .filter()
              .gameModeEqualTo(
                  AppFunctions.getDifficultyValue(gameStatistics.gameMode))
              .scoreLessThan(gameStatistics.score)
              .findAll();
        }
      }

      ScoresDataModel newScoreGameData = ScoresDataModel(
        userId: AuthService.userData!.id,
        userName: gameStatistics.recordName ??
            'Game Record ${DateTime.now().toString().split('.')[0]}',
        attempts: gameStatistics.attempts,
        ranking: 1,
        score: gameStatistics.score,
        time: gameStatistics.time,
        date: DateTime.timestamp(),
        gameMode: AppFunctions.getDifficultyValue(gameStatistics.gameMode),
      );

      if (scoreList.isNotEmpty) {
        scoreList.sort((a, b) => b.score.compareTo(a.score));
        newScoreGameData.ranking = scoreList[0].ranking;

        for (var scoreItem in scoreList) {
          scoreItem.ranking = scoreItem.ranking + 1;
        }
        scoreList.insert(0, newScoreGameData);
        scoreList.removeWhere((element) => element.ranking > 20);

        return await uploadGameScoreToLocal(scoreList);
      } else {
        if (lastScoreItem != null) {
          newScoreGameData.ranking = lastScoreItem.ranking + 1;
          scoreList.add(newScoreGameData);
        } else {
          scoreList.add(newScoreGameData);
        }
        if (newScoreGameData.ranking > 20) return false;

        return await uploadGameScoreToLocal(scoreList);
      }
    } catch (e) {
      throw LocalException(
          message: 'An error occurred while registering the score game',
          type: ExceptionType.gameException);
    }
  }

  @override
  Future<bool> uploadGameScoreToLocal(
      List<ScoresDataModel> scoreDataList) async {
    try {
      final Isar isarDb = await isarIntance;

      isarDb.writeTxnSync(
        () => isarDb.scoresDataModels.putAllSync(scoreDataList),
      );

      return true;
    } catch (e) {
      throw LocalException(
          message:
              'An error has occurred when uploading the game score to storage',
          type: ExceptionType.gameException);
    }
  }
}
