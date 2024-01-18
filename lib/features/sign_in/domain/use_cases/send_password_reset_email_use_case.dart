import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/sign_in/domain/repositories/sign_in_repository.dart';

import 'package:dartz/dartz.dart';

class SendPasswordResetEmailUseCase extends UseCase<bool, String> {
  final SignInRepository signInRepository;

  SendPasswordResetEmailUseCase({required this.signInRepository});

  @override
  Future<Either<ServerFailure, bool>> call(String params) {
    return signInRepository.sendPasswordResetEmail(params);
  }
}
