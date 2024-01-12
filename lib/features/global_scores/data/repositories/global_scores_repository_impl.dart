import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/data/datasources/global_scores_data_source.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';

import 'package:dartz/dartz.dart';

class GlobalScoresRepositoryImpl extends GlobalScoresRepository {
  final GlobalScoresDataSource globalScoresDataSource;

  GlobalScoresRepositoryImpl({required this.globalScoresDataSource});

  @override
  Future<Either<GlobalScoresFailure, List<GlobalScoreEntity>>>
      getGlobalScoreList(int gameMode) async {
    try {
      return Right(
        await globalScoresDataSource.getGlobalScoresList(gameMode),
      );
    } on GlobalScoresException catch (e) {
      return Left(
        GlobalScoresFailure(message: e.message),
      );
    }
  }
}
