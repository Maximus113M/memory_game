import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';

import 'firebase_env.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static User? currentUser;
  static UserDataModel? userData;
  static UserSettingsModel? userSettings;

  final FirebaseAuth firebaseAuth;

  AuthService({required this.firebaseAuth});

  static Future firebaseInit() {
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void isUserAuth() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    firebaseAuth.currentUser; //TODO: PENDIENTE CURRENT-USER
  }
}
