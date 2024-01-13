import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashProvider with ChangeNotifier {
  FirebaseAuth firebaseAuth;

  SplashProvider({required this.firebaseAuth});

  void appInit(BuildContext context) async {
    if (firebaseAuth.currentUser != null) {
      await Future.delayed(const Duration(milliseconds: 4000))
          .then((value) => GoRouter.of(context).go('/home'));
      return;
    }
    await Future.delayed(const Duration(milliseconds: 4000))
        .then((value) => GoRouter.of(context).go('/login'));
  }
}
