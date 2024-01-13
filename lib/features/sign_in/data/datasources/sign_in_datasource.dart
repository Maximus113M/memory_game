import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInDataSource {
  Future<UserCredential?> loginWithEmailAndPassword(SignInUserData signInData);

  Future<UserCredential?> createUserWithEmailAndPassword(
      SignInUserData signUpData);

  Future<void> registerUserDb(SignInUserData signUpData, User? user);
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
      throw LoginException(
        message: message,
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
      throw LoginException(
        message: message,
      );
    } on LoginException catch (e) {
      throw LoginException(
        message: e.message,
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
      throw LoginException(
        message: 'An error occurred while registering the user',
      );
    }
  }
}
