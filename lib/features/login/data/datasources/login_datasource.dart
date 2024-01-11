import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/login/data/models/email_and_password_data.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginDataSource {
  Future<UserCredential?> loginWithEmailAndPassword(
      EmailAndPasswordData emailAndPasswordData);

  Future<UserCredential?> createUserWithEmailAndPassword(
      EmailAndPasswordData emailAndPasswordData);
}

class LoginDataSourceImpl extends LoginDataSource {
  final FirebaseAuth firebaseAuth;

  LoginDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserCredential?> loginWithEmailAndPassword(
      EmailAndPasswordData emailAndPasswordData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: emailAndPasswordData.email,
              password: emailAndPasswordData.password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Login error, please, check your credentials';

      if (e.code == 'user-not-found') {
        message = 'User not found';
      }
      if (e.code == 'wrong-password') {
        message = 'Wrong password';
      }
      throw LoginException(
        message: message,
      );
    }
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
      EmailAndPasswordData emailAndPasswordData) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailAndPasswordData.email,
              password: emailAndPasswordData.password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Error de Registro';

      if (e.code == 'email-already-in-use') {
        message = 'El correo ya se encuentra en uso';
      }
      if (e.code == 'weak-password') {
        message = 'Contraseña debil';
      }
      throw LoginException(
        message: message,
      );
    }
  }
}
