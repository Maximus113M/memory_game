import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/global_config/domain/repositories/global_config_repository.dart';

import 'package:dartz/dartz.dart';

class UpdatePasswordUseCase extends UseCase<bool, String> {
  final GlobalConfigRepository globalConfigRepository;

  UpdatePasswordUseCase({required this.globalConfigRepository});
  @override
  Future<Either<ServerFailure, bool>> call(String params) async {
    return await globalConfigRepository.updatePassword(params);
  }
}
