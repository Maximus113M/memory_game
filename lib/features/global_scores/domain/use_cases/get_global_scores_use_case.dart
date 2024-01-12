import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';

import 'package:dartz/dartz.dart';

class GetGlobalScoresStreamUseCase
    extends UseCase<List<GlobalScoreEntity>, int> {
  final GlobalScoresRepository globalScoresRepository;

  GetGlobalScoresStreamUseCase({required this.globalScoresRepository});

  @override
  Future<Either<GlobalScoresFailure, List<GlobalScoreEntity>>> call(
      int params) async {
    return await globalScoresRepository.getGlobalScoreList(params);
  }
}
