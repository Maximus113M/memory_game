import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GlobalScoresDataSource {
  Future<List<GlobalScoreEntity>> getGlobalScoresList(int gameMode);
}

class GlobalScoresDataSourceImpl extends GlobalScoresDataSource {
  final FirebaseFirestore db;

  GlobalScoresDataSourceImpl({required this.db});

  @override
  Future<List<GlobalScoreEntity>> getGlobalScoresList(int gameMode) async {
    try {
      List<GlobalScoreEntity> globalScoresList = [];
      final QuerySnapshot queryGlobalScores = await db
          .collection(Server.globalScores)
          .where("game_mode", isEqualTo: gameMode)
          .get();

      for (var document in queryGlobalScores.docs) {
        globalScoresList.add(GlobalScoreEntity.fromJson(document));
      }
      return globalScoresList;
    } catch (e) {
      throw GlobalScoresException(message: 'A server error has occurred');
    }
  }
}
