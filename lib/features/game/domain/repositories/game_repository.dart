import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';

import 'package:dartz/dartz.dart';

abstract class GameRepository {
  Future<Either<ServerFailure, bool>> registerScoreGame(
      GameStatisticsModel gameStatistics);
}
