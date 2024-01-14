import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/global_scores/data/datasources/global_scores_data_source.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';

import 'package:dartz/dartz.dart';

class GlobalScoresRepositoryImpl extends GlobalScoresRepository {
  final GlobalScoresDataSource globalScoresDataSource;

  GlobalScoresRepositoryImpl({required this.globalScoresDataSource});

  @override
  Future<Either<ServerFailure, List<ScoresDataModel>>> getGlobalScoreList(
      int gameMode) async {
    try {
      return Right(
        await globalScoresDataSource.getGlobalScoresList(gameMode),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, type: e.type),
      );
    }
  }
}
