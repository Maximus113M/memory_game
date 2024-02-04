import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';
import 'package:memory_game/features/global_config/domain/repositories/global_config_repository.dart';

import 'package:dartz/dartz.dart';

class UpdateUserSettingsUseCase extends UseCase<bool, UserSettingsModel> {
  final GlobalConfigRepository globalConfigRepository;

  UpdateUserSettingsUseCase({required this.globalConfigRepository});
  @override
  Future<Either<LocalFailure, bool>> call(UserSettingsModel params) async {
    return await globalConfigRepository.updateUserSettings(params);
  }
}
