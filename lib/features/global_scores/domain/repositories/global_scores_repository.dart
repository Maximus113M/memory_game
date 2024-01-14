import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';

import 'package:dartz/dartz.dart';

abstract class GlobalScoresRepository {
  Future<Either<ServerFailure, List<ScoresDataModel>>> getGlobalScoreList(
      int gameMode);
}
