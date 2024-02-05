import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';

import 'package:isar/isar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SplashDataSource {
  Future<bool> isUserSignIn();
}

class SplashDataSourceImpl extends SplashDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore db;
  late Future<Isar> isarIntance;

  SplashDataSourceImpl({required this.firebaseAuth, required this.db}) {
    isarIntance = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UserSettingsModelSchema, ScoresDataModelSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isUserSignIn() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final userJsonData =
            await db.doc('${Server.users}/${currentUser.uid}').get();
        final userData = UserDataModel.fromJson(userJsonData);

        final Isar isar = await isarIntance;
        var result = isar.userSettingsModels
            .filter()
            .userIdEqualTo(currentUser.uid)
            .findFirstSync();
        print("USER SETTINGS $result");
        AuthService.userData = userData;
        AuthService.currentUser = currentUser;
        AuthService.userSettings = result;

        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message:
              'An error occurred while checking the session, please sign in',
          type: ExceptionType.sharedException);
    }
  }
}
