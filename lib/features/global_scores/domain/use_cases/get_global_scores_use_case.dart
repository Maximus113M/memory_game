import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';

import 'package:dartz/dartz.dart';

class GetGlobalScoresUseCase extends UseCase<List<ScoresDataModel>, int> {
  final GlobalScoresRepository globalScoresRepository;

  GetGlobalScoresUseCase({required this.globalScoresRepository});

  @override
  Future<Either<ServerFailure, List<ScoresDataModel>>> call(int params) async {
    return await globalScoresRepository.getGlobalScoreList(params);
  }
}
