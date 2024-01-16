import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/game/data/models/game_statistics_model.dart';
import 'package:memory_game/features/game/domain/repositories/game_repository.dart';

import 'package:dartz/dartz.dart';

class ScoreDbRegisterUseCase extends UseCase<bool, GameStatisticsModel> {
  final GameRepository gameRepository;

  ScoreDbRegisterUseCase({required this.gameRepository});

  @override
  Future<Either<ServerFailure, bool>> call(GameStatisticsModel params) async {
    return await gameRepository.gameScoreDbRegister(params);
  }
}
