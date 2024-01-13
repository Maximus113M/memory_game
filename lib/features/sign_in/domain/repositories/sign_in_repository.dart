import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<Either<LoginFailure, UserCredential?>> loginWithEmailAndPassword(
      SignInUserData signInData);

  Future<Either<LoginFailure, UserCredential?>> createWithEmailAndPassword(
      SignInUserData signUpData);
}
