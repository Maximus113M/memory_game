import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/local_scores/domain/repositories/local_scores_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteLocalScoreUseCase extends UseCase<bool, ScoresDataModel> {
  final LocalScoresRepository localScoresRepository;

  DeleteLocalScoreUseCase({required this.localScoresRepository});

  @override
  Future<Either<LocalFailure, bool>> call(ScoresDataModel params) async {
    return await localScoresRepository.deleteLocalScore(params);
  }
}
