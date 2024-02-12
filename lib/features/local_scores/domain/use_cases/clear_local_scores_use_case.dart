import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/local_scores/domain/repositories/local_scores_repository.dart';

import 'package:dartz/dartz.dart';

class ClearLocalScoresUseCase extends UseCase<bool, int> {
  final LocalScoresRepository localScoresRepository;

  ClearLocalScoresUseCase({required this.localScoresRepository});

  @override
  Future<Either<LocalFailure, bool>> call(int params) async {
    return await localScoresRepository.clearLocalScores(params);
  }
}
