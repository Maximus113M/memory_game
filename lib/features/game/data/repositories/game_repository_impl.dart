import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/features/game/data/datasources/game_data_source.dart';
import 'package:memory_game/features/game/domain/repositories/game_repository.dart';

import 'package:dartz/dartz.dart';

class GameRepositoryImpl extends GameRepository {
  final GameDataSource gameDataSource;

  GameRepositoryImpl({required this.gameDataSource});

  @override
  Future<Either<ServerFailure, bool>> registerScoreGame(
      GameStatisticsModel gameStatistics) async {
    try {
      return Right(await gameDataSource.registerGameScore(gameStatistics));
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message, type: e.type);
    }
  }
}
