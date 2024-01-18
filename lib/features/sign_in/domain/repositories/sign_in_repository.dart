import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<Either<ServerFailure, UserCredential?>> loginWithEmailAndPassword(
      SignInUserData signInData);

  Future<Either<ServerFailure, UserCredential?>> createWithEmailAndPassword(
      SignInUserData signUpData);

  Future<Either<ServerFailure, bool>> verifyCurrentSession(NoParams signUpData);

  Future<Either<ServerFailure, bool>> sendPasswordResetEmail(String email);
}
