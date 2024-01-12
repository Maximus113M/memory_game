import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';

import 'package:dartz/dartz.dart';

abstract class GlobalScoresRepository {
  Future<Either<GlobalScoresFailure, List<GlobalScoreEntity>>>
      getGlobalScoreList(int gameMode);
}
