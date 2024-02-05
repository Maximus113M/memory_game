import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';

import 'package:isar/isar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GlobalConfigDatasource {
  Future<bool> updateUserName(String name);
  Future<bool> updateEmail(String email);
  Future<bool> updatePassword(String password);
  Future<bool> deleteAccount();
  Future<bool> validateCrentials(String password);
  Future<bool> updateUserSettings(UserSettingsModel newUserSettings);
}

class GlobalConfigDatasourceImpl extends GlobalConfigDatasource {
  final FirebaseFirestore db;
  late Future<Isar> isarIntance;

  GlobalConfigDatasourceImpl({required this.db}) {
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
  Future<bool> updateUserName(String name) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        await db
            .doc('${Server.users}/${currentUser.uid}')
            .update({'name': name});
        final QuerySnapshot<Map<String, dynamic>> userRecords = await db
            .collection(Server.globalScores)
            .where('user_id', isEqualTo: currentUser.uid)
            .get();
        for (var doc in userRecords.docs) {
          await db
              .doc('${Server.globalScores}/${doc.id}')
              .update({'user_name': name});
        }
        AuthService.userData!.name = name;
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error was ocurred while updating the data',
          type: ExceptionType.globalConfigureException);
    }
  }

  @override
  Future<bool> updateEmail(String email) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        await currentUser.updateEmail(email);
        await db
            .doc('${Server.users}/${currentUser.uid}')
            .update({'email': email});

        AuthService.userData!.email = email;
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while updating the email',
          type: ExceptionType.globalConfigureException);
    }
  }

  @override
  Future<bool> updatePassword(String password) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(password);
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while updating the password',
          type: ExceptionType.globalConfigureException);
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        /*final QuerySnapshot<Map<String, dynamic>> userRecords = await db
            .collection(Server.globalScores)
            .where('user_id', isEqualTo: currentUser.uid)
            .get();

        for (var doc in userRecords.docs) {
          await db.doc('${Server.globalScores}/${doc.id}').delete();
        }*/
        await db.doc('${Server.users}/${currentUser.uid}').delete();
        await currentUser.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while trying to delete the user',
          type: ExceptionType.globalConfigureException);
    }
  }

  @override
  Future<bool> validateCrentials(String password) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        final AuthCredential credential = EmailAuthProvider.credential(
            email: currentUser.email!, password: password);
        await currentUser.reauthenticateWithCredential(credential);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred while trying to validate';
      if (e.code == 'invalid-credential') {
        message = 'Wrong password, please, try again';
      }
      throw ServerException(
        message: message,
        type: ExceptionType.globalConfigureException,
      );
    }
  }

  @override
  Future<bool> updateUserSettings(UserSettingsModel newUserSettings) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        final isar = await isarIntance;
        UserSettingsModel? userConfig = await isar.userSettingsModels
            .filter()
            .userIdEqualTo(currentUser.uid)
            .findFirst();
        late UserSettingsModel finalUserSettings;
        if (userConfig != null) {
          userConfig.updateUserSettings(newUserSettings);
          finalUserSettings = userConfig;
        } else {
          finalUserSettings = newUserSettings;
        }
        isar.writeTxnSync(
            () => isar.userSettingsModels.putSync(finalUserSettings));

        AuthService.userSettings = finalUserSettings;
        return true;
      }
      return false;
    } on IsarError catch (e) {
      throw LocalException(
        message: e.message,
        type: ExceptionType.globalConfigureException,
      );
    } catch (e) {
      throw LocalException(
        message: 'An error occurred while trying to get your game preferences',
        type: ExceptionType.globalConfigureException,
      );
    }
  }
}
