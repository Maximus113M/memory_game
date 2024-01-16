import 'dart:io';

import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalScoresDataSource {
  Future<List<ScoresDataModel>> getLocalScoreList(int gameMode);

  Future<bool> clearLocalScores();
}

class LocalScoresDataSourceImpl extends LocalScoresDataSource {
  late Future<Isar> isarIntance;

  LocalScoresDataSourceImpl() {
    isarIntance = openIsar();
  }

  Future<Isar> openIsar() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ScoresDataModelSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<ScoresDataModel>> getLocalScoreList(int gameMode) async {
    try {
      final Isar isarDb = await isarIntance;
      final List<ScoresDataModel> scoreList = await isarDb.scoresDataModels
          .filter()
          .gameModeEqualTo(gameMode)
          .sortByScore()
          .findAll();
      scoreList.sort((a, b) => a.rank.compareTo(b.rank));
      return scoreList;
    } catch (e) {
      print(e);
      throw IsarPreferencesException(
        message: 'A local data error has occurred',
        type: ExceptionType.isarPreferencesException,
      );
    }
  }

  @override
  Future<bool> clearLocalScores() async {
    try {
      final Isar isarDb = await isarIntance;
      await isarDb.writeTxn(
        () => isarDb.scoresDataModels.clear(),
      );
      return true;
    } catch (e) {
      throw IsarPreferencesException(
          message: 'An error occurred while deleting the game score',
          type: ExceptionType.gameException);
    }
  }
}
