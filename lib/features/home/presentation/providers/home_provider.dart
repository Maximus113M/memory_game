import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memory_game/core/shared/models/main_menu_model.dart';

class HomeProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  List<MainMenuModel> menuList = MainMenuModel.mainMenuList();
  bool isInSession = true;

  HomeProvider({required this.firebaseAuth});

  signOut(BuildContext context) {
    firebaseAuth
        .signOut()
        .then((value) => GoRouter.of(context).pushReplacement('/login'));
    isInSession = true;
  }
}

enum GameDifficulty { easy, medium, hard }
