import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';
import 'package:memory_game/features/sign_in/domain/repositories/sign_in_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithEmailAndPasswordUseCase
    extends UseCase<UserCredential?, SignInUserData> {
  final SignInRepository signInRepository;

  LoginWithEmailAndPasswordUseCase({required this.signInRepository});

  @override
  Future<Either<LoginFailure, UserCredential?>> call(SignInUserData params) {
    return signInRepository.loginWithEmailAndPassword(params);
  }
}
