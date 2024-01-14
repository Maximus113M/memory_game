import 'package:memory_game/core/errors/failures.dart';
import 'package:memory_game/core/helpers/use_case.dart';
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
  Future<Either<ServerFailure, UserCredential?>> loginWithEmailAndPassword(
      SignInUserData signInData) async {
    try {
      return Right(
        await signInDataSource.loginWithEmailAndPassword(signInData),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.singInException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, UserCredential?>> createWithEmailAndPassword(
      SignInUserData signUpData) async {
    try {
      return Right(
        await signInDataSource.createUserWithEmailAndPassword(signUpData),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.singInException,
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> verifyCurrentSession(
      NoParams noParams) async {
    try {
      return Right(await signInDataSource.verifyCurrentSession());
    } on ServerException catch (e) {
      return left(
        ServerFailure(
          message: e.message,
          type: ExceptionType.singInException,
        ),
      );
    }
  }
}
