import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/sign_in/domain/repositories/sign_in_repository.dart';

import 'package:dartz/dartz.dart';

class VerifyCurrentSessionUseCase extends UseCase<bool, NoParams> {
  final SignInRepository signInRepository;

  VerifyCurrentSessionUseCase({required this.signInRepository});

  @override
  Future<Either<ServerFailure, bool>> call(NoParams params) {
    return signInRepository.verifyCurrentSession(params);
  }
}
