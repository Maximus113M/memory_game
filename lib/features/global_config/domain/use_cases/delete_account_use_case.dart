import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/global_config/domain/repositories/global_config_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteAccountUseCase extends UseCase<bool, NoParams> {
  final GlobalConfigRepository globalConfigRepository;

  DeleteAccountUseCase({required this.globalConfigRepository});
  @override
  Future<Either<ServerFailure, bool>> call(NoParams params) async {
    return await globalConfigRepository.deleteAccount(params);
  }
}
