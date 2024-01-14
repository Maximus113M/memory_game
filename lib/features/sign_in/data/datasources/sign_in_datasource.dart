import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SignInDataSource {
  Future<UserCredential?> loginWithEmailAndPassword(SignInUserData signInData);

  Future<UserCredential?> createUserWithEmailAndPassword(
      SignInUserData signUpData);

  Future<void> registerUserDb(SignInUserData signUpData, User? user);

  Future<bool> verifyCurrentSession();
}

class SignInDataSourceImpl extends SignInDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore db;

  SignInDataSourceImpl({required this.firebaseAuth, required this.db});

  @override
  Future<UserCredential?> loginWithEmailAndPassword(
      SignInUserData signInData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: signInData.email, password: signInData.password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Login error, please, check your credentials';

      if (e.code == 'user-not-found') {
        message = 'User not found';
      }
      if (e.code == 'wrong-password') {
        message = 'Wrong password';
      }
      throw ServerException(
        message: message,
        type: ExceptionType.singInException,
      );
    }
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
      SignInUserData signUpData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: signUpData.email, password: signUpData.password);

      await registerUserDb(signUpData, userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Error de Registro';

      if (e.code == 'email-already-in-use') {
        message = 'El correo ya se encuentra en uso';
      }
      if (e.code == 'weak-password') {
        message = 'Contraseña debil';
      }
      throw ServerException(
          message: message, type: ExceptionType.singInException);
    } on ServerException catch (e) {
      throw ServerException(
        message: e.message,
        type: e.type,
      );
    }
  }

  @override
  Future<void> registerUserDb(SignInUserData signUpData, User? user) async {
    try {
      if (user != null) {
        signUpData.id = user.uid;
        await db
            .collection("users")
            .doc(user.uid)
            .set(signUpData.toFirestore());
      }
    } catch (e) {
      throw ServerException(
        message: 'An error occurred while registering the user',
        type: ExceptionType.singInException,
      );
    }
  }

  @override
  Future<bool> verifyCurrentSession() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      AuthService.currentUser = currentUser;

      if (currentUser != null) {
        final userJsonData =
            await db.doc('${Server.users}/${currentUser.uid}').get();

        final userData = UserDataModel.fromJson(userJsonData);
        AuthService.userData = userData;
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
        message: 'An error occurred while checking the session',
        type: ExceptionType.singInException,
      );
    }
  }
}
