import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GlobalScoresDataSource {
  Future<List<ScoresDataModel>> getGlobalScoresList(int gameMode);
}

class GlobalScoresDataSourceImpl extends GlobalScoresDataSource {
  final FirebaseFirestore db;

  GlobalScoresDataSourceImpl({required this.db});

  @override
  Future<List<ScoresDataModel>> getGlobalScoresList(int gameMode) async {
    try {
      List<ScoresDataModel> globalScoresList = [];
      final QuerySnapshot queryGlobalScores = await db
          .collection(Server.globalScores)
          .where("game_mode", isEqualTo: gameMode)
          .orderBy('score', descending: true)
          .get();

      for (var document in queryGlobalScores.docs) {
        globalScoresList.add(ScoresDataModel.fromJson(document));
      }
      globalScoresList.sort((a, b) => b.score.compareTo(a.score));

      return globalScoresList;
    } catch (e) {
      throw ServerException(
        message: 'A server error has occurred',
        type: ExceptionType.globalScoresException,
      );
    }
  }
}
