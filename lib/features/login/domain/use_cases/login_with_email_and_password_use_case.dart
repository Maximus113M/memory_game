import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/login/data/models/email_and_password_data.dart';
import 'package:memory_game/features/login/domain/repositories/login_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithEmailAndPasswordUseCase
    extends UseCase<UserCredential?, EmailAndPasswordData> {
  final LoginRepository loginRepository;

  LoginWithEmailAndPasswordUseCase({required this.loginRepository});

  @override
  Future<Either<LoginFailure, UserCredential?>> call(
      EmailAndPasswordData params) {
    return loginRepository.loginWithEmailAndPassword(params);
  }
}
