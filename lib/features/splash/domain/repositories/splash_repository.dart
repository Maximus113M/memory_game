import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';

import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  Future<Either<ServerFailure, bool>> isUserSignIn(NoParams noParams);
}
