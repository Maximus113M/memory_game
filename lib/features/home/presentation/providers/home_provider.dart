import 'package:flutter/material.dart';
import 'package:memory_game/core/services/audio_service.dart';
import 'package:memory_game/core/shared/models/home_menu_model.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeProvider extends ChangeNotifier with WidgetsBindingObserver {
  final FirebaseAuth firebaseAuth;
  List<HomeMenuModel> menuList = HomeMenuModel.homeMenuList();
  bool isInSession = true;
  bool isMusicSound = false;
  AppLifecycleState? _notification;

  HomeProvider({required this.firebaseAuth});

  signOut(BuildContext context) {
    firebaseAuth.signOut().then((value) {
      AudioService().quitAllSounds();
      WidgetsBinding.instance.removeObserver(this);
      isMusicSound = false;
      GoRouter.of(context).pushReplacement('/login');
    });
    isInSession = true;
  }

  void initMusic() {
    if (isMusicSound) return;
    initObserver();
    AudioService().playGameMusic();
    isMusicSound = true;
  }

  void initObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notification = state;
    if (_notification == AppLifecycleState.resumed) {
      AudioService().playGameMusic();
    } else {
      AudioService().pauseMusic();
    }
  }
}
