import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/local_scores/domain/repositories/local_scores_repository.dart';

import 'package:dartz/dartz.dart';

class GetLocalScoresUseCase extends UseCase<List<ScoresDataModel>, int> {
  final LocalScoresRepository localScoresRepository;

  GetLocalScoresUseCase({required this.localScoresRepository});

  @override
  Future<Either<LocalFailure, List<ScoresDataModel>>> call(int params) async {
    return await localScoresRepository.getLocalScoreList(params);
  }
}
