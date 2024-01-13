import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';
import 'package:memory_game/features/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:memory_game/features/sign_in/domain/repositories/sign_in_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInDataSource signInDataSource;

  SignInRepositoryImpl({required this.signInDataSource});

  @override
  Future<Either<LoginFailure, UserCredential?>> loginWithEmailAndPassword(
      SignInUserData signInData) async {
    try {
      return Right(
        await signInDataSource.loginWithEmailAndPassword(signInData),
      );
    } on LoginException catch (e) {
      return Left(
        LoginFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<LoginFailure, UserCredential?>> createWithEmailAndPassword(
      SignInUserData signUpData) async {
    try {
      return Right(
        await signInDataSource.createUserWithEmailAndPassword(signUpData),
      );
    } on LoginException catch (e) {
      return Left(
        LoginFailure(message: e.message),
      );
    }
  }
}
