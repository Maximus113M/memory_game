import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/splash/data/datasources/splash_data_source.dart';
import 'package:memory_game/features/splash/domain/repositories/splash_repository.dart';

import 'package:dartz/dartz.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashDataSource splashDataSource;

  SplashRepositoryImpl({required this.splashDataSource});

  @override
  Future<Either<ServerFailure, bool>> isUserSignIn(NoParams noParams) async {
    try {
      return Right(await splashDataSource.isUserSignIn());
    } on ServerException catch (e) {
      throw ServerFailure(
        message: e.message,
        type: e.type,
      );
    }
  }
}
