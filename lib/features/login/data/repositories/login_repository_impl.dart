import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/login/data/datasources/login_datasource.dart';
import 'package:memory_game/features/login/data/models/email_and_password_data.dart';
import 'package:memory_game/features/login/domain/repositories/login_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<Either<Failure, UserCredential?>> loginWithEmailAndPassword(
      EmailAndPasswordData emailAndPassword) async {
    try {
      return Right(
        await loginDataSource.loginWithEmailAndPassword(emailAndPassword),
      );
    } on LoginException catch (e) {
      return Left(
        LoginFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> createWithEmailAndPassword(
      EmailAndPasswordData emailAndPassword) async {
    try {
      return Right(
        await loginDataSource.createUserWithEmailAndPassword(emailAndPassword),
      );
    } on LoginException catch (e) {
      return Left(
        LoginFailure(message: e.message),
      );
    }
  }
}
