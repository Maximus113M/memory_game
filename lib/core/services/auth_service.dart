//import 'package:memory_game/core/errors/exceptions.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService({required this.firebaseAuth});

  static Future firebaseInit() {
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /*Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
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
  }*/

  /*Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = 'Error al Iniciar Sesion';

      if (e.code == 'user-not-found') {
        message = 'Usuario no encontrado';
      }
      if (e.code == 'wrong-password') {
        message = 'Contraseña incorrecta';
      }
      throw LoginException(
        message: message,
      );
    }
  }*/

  isUserAuth() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
