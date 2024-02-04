import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';

abstract class GlobalConfigRepository {
  Future<Either<ServerFailure, bool>> updateUserName(String name);
  Future<Either<ServerFailure, bool>> updateEmail(String email);
  Future<Either<ServerFailure, bool>> updatePassword(String password);
  Future<Either<ServerFailure, bool>> deleteAccount(NoParams params);
  Future<Either<ServerFailure, bool>> validateCredentials(String password);
  Future<Either<LocalFailure, bool>> updateUserSettings(
      UserSettingsModel newUserSettings);
}
