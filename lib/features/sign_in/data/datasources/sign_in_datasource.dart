import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';

import 'package:isar/isar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SignInDataSource {
  Future<UserCredential?> loginWithEmailAndPassword(SignInUserData signInData);

  Future<UserCredential?> createUserWithEmailAndPassword(
      SignInUserData signUpData);

  Future<void> registerUserDb(SignInUserData signUpData, User? user);

  Future<bool> verifyCurrentSession();

  Future<bool> sendPasswordResetEmail(String email);
}

class SignInDataSourceImpl extends SignInDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore db;
  late Future<Isar> isarIntance;

  SignInDataSourceImpl({required this.firebaseAuth, required this.db}) {
    isarIntance = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UserSettingsModelSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

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

      await setFirstUserSettings(userCredential.user);

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

  Future<void> setFirstUserSettings(User? user) async {
    try {
      if (user == null) return;
      final Isar isar = await openIsar();
      UserSettingsModel firstUserSettings = UserSettingsModel(
        userId: user.uid,
        gameMode: GameDifficulty.easy,
        memorizingTime: 5,
        isCloudEnabled: false,
        isInGameMusicEnabled: true,
        isGameSoundsEnabled: true,
      );
      isar.writeTxnSync(() => isar.userSettingsModels.put(firstUserSettings));
    } catch (e) {
      throw LocalException(
          message:
              'An error occurred while trying to set the user\'s game configuration',
          type: ExceptionType.localException);
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
        AuthService.userSettings = await getUserSettings(currentUser);

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

  Future<UserSettingsModel?> getUserSettings(User user) async {
    try {
      final Isar isar = await isarIntance;

      return isar.userSettingsModels
          .filter()
          .userIdEqualTo(user.uid)
          .findFirst();
    } catch (e) {
      throw LocalException(
        message:
            'An error occurred while trying to get the user\'s game configuration',
        type: ExceptionType.userSettingsException,
      );
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      bool emailWasSent = false;
      await firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => emailWasSent = true);
      return emailWasSent;
    } catch (e) {
      throw ServerException(
        message: 'Could not send the confirmation to your email',
        type: ExceptionType.singInException,
      );
    }
  }
}
