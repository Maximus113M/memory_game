import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';

import 'package:dartz/dartz.dart';

abstract class LocalScoresRepository {
  Future<Either<LocalFailure, List<ScoresDataModel>>> getLocalScoreList(
      int gameMode);
  Future<Either<LocalFailure, bool>> clearLocalScoresByGameMode(int gameMode);

  Future<Either<LocalFailure, bool>> deleteLocalScore(
      ScoresDataModel scoreRecord);
}
