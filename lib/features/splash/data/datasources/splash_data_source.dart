import 'package:memory_game/core/services/server.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/user_data_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SplashDataSource {
  Future<bool> isUserSignIn();
}

class SplashDataSourceImpl extends SplashDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore db;

  SplashDataSourceImpl({required this.firebaseAuth, required this.db});
  @override
  Future<bool> isUserSignIn() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final userJsonData =
            await db.doc('${Server.users}/${currentUser.uid}').get();

        final userData = UserDataModel.fromJson(userJsonData);
        AuthService.userData = userData;
        AuthService.currentUser = currentUser;
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
