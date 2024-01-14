import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/splash/domain/repositories/splash_repository.dart';

import 'package:dartz/dartz.dart';

class IsUserSignInUseCase extends UseCase<bool, NoParams> {
  final SplashRepository splashRepository;

  IsUserSignInUseCase({required this.splashRepository});

  @override
  Future<Either<ServerFailure, bool>> call(NoParams params) {
    return splashRepository.isUserSignIn(params);
  }
}
