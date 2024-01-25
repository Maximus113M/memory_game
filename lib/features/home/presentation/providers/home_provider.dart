import 'package:flutter/material.dart';
import 'package:memory_game/core/services/audio_service.dart';
import 'package:memory_game/core/shared/models/home_menu_model.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  List<HomeMenuModel> menuList = HomeMenuModel.homeMenuList();
  bool isInSession = true;
  bool isMusicSound = false;

  HomeProvider({required this.firebaseAuth});

  signOut(BuildContext context) {
    firebaseAuth.signOut().then((value) {
      AudioService().quitMusic();
      isMusicSound = false;
      GoRouter.of(context).pushReplacement('/login');
    });
    isInSession = true;
  }

  void initMusic() {
    if (isMusicSound) return;
    AudioService().playGameMusic();
    isMusicSound = true;
  }
}
