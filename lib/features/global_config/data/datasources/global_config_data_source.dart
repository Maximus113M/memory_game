import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_game/core/errors/exceptions.dart';
import 'package:memory_game/core/services/auth_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_game/core/services/server.dart';

abstract class GlobalConfigDatasource {
  Future<bool> updateUserName(String name);
  Future<bool> updateEmail(String email);
  Future<bool> updatePassword(String password);
  Future<bool> deleteAccount();
  Future<bool> validateCrentials(String password);
}

class GlobalConfigDatasourceImpl extends GlobalConfigDatasource {
  final FirebaseFirestore db;

  GlobalConfigDatasourceImpl({required this.db});

  @override
  Future<bool> updateUserName(String name) async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        await db
            .doc('${Server.users}/${currentUser.uid}')
            .update({'name': name});
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error was ocurred while updating the data',
          type: ExceptionType.gobalConfigureException);
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
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while updating the email',
          type: ExceptionType.gobalConfigureException);
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
          type: ExceptionType.gobalConfigureException);
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        await currentUser.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(
          message: 'An error occurred while trying to delete the user',
          type: ExceptionType.gobalConfigureException);
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
        type: ExceptionType.gobalConfigureException,
      );
    }
  }
}
