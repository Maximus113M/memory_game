import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/features/login/data/models/email_and_password_data.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserCredential?>> loginWithEmailAndPassword(
      EmailAndPasswordData emailAndPassword);

  Future<Either<Failure, UserCredential?>> createWithEmailAndPassword(
      EmailAndPasswordData emailAndPassword);
}
