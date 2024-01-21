import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/global_config/data/datasources/global_config_data_source.dart';
import 'package:memory_game/features/global_config/domain/repositories/global_config_repository.dart';

import 'package:dartz/dartz.dart';

class GlobalConfigRepositoryImpl extends GlobalConfigRepository {
  final GlobalConfigDatasource globalConfigDatasource;

  GlobalConfigRepositoryImpl({required this.globalConfigDatasource});

  @override
  Future<Either<ServerFailure, bool>> updateUserName(String name) async {
    try {
      return Right(
        await globalConfigDatasource.updateUserName(name),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.gobalConfigureException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> updateEmail(String email) async {
    try {
      return Right(
        await globalConfigDatasource.updateEmail(email),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.gobalConfigureException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> updatePassword(String password) async {
    try {
      return Right(
        await globalConfigDatasource.updatePassword(password),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.gobalConfigureException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> deleteAccount(NoParams params) async {
    try {
      return Right(
        await globalConfigDatasource.deleteAccount(),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.gobalConfigureException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> validateCredentials(
      String password) async {
    try {
      return Right(
        await globalConfigDatasource.validateCrentials(password),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.gobalConfigureException,
        ),
      );
    }
  }
}
