import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';

import 'package:dartz/dartz.dart';

abstract class GlobalConfigRepository {
  Future<Either<ServerFailure, bool>> updateUserName(String name);
  Future<Either<ServerFailure, bool>> updateEmail(String email);
  Future<Either<ServerFailure, bool>> updatePassword(String password);
  Future<Either<ServerFailure, bool>> deleteAccount(NoParams params);
  Future<Either<ServerFailure, bool>> validateCredentials(String password);
}
