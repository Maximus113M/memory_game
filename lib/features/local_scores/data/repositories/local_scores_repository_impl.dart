import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/local_scores/data/datasources/local_scores_data_source.dart';
import 'package:memory_game/features/local_scores/domain/repositories/local_scores_repository.dart';

import 'package:dartz/dartz.dart';

class LocalScoresRepositoryImpl extends LocalScoresRepository {
  final LocalScoresDataSource localScoresDataSource;

  LocalScoresRepositoryImpl({required this.localScoresDataSource});

  @override
  Future<Either<SharedPreferencesFailure, List<ScoresDataModel>>>
      getLocalScoreList(int gameMode) async {
    try {
      return Right(
        await localScoresDataSource.getLocalScoreList(gameMode),
      );
    } on IsarPreferencesException catch (e) {
      return Left(
        SharedPreferencesFailure(message: e.message, type: e.type),
      );
    }
  }

  @override
  Future<Either<SharedPreferencesFailure, bool>> clearLocalScores(
      NoParams noParams) async {
    try {
      return Right(
        await localScoresDataSource.clearLocalScores(),
      );
    } on IsarPreferencesException catch (e) {
      return Left(
        SharedPreferencesFailure(message: e.message, type: e.type),
      );
    }
  }
}
