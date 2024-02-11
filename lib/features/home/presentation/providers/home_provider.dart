import 'package:flutter/material.dart';
import 'package:memory_game/core/services/audio_service.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/models/home_menu_model.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/global_config/presentation/providers/global_config_provider.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier with WidgetsBindingObserver {
  final FirebaseAuth firebaseAuth;
  List<HomeMenuModel> menuList = HomeMenuModel.homeMenuList();
  bool isLocalList = false;
  bool isInSession = false;
  bool isPlayingMusic = false;
  AppLifecycleState? _notification;

  HomeProvider({required this.firebaseAuth});

  signOut(BuildContext context) {
    firebaseAuth.signOut().then((value) {
      AudioService().quitAllSounds();
      WidgetsBinding.instance.removeObserver(this);
      AuthService.logOut();
      isPlayingMusic = false;
      GoRouter.of(context).pushReplacement('/login');
    });
    isInSession = false;
  }

  void initHome(BuildContext context) {
    if (!isInSession) {
      UserSettingsModel? userSettings = AuthService.userSettings;
      if (userSettings != null) {
        context
            .read<GlobalConfigProvider>()
            .initGlobalConfigValues(context, userSettings);

        context.read<GameProvider>().initGameSettings(userSettings);

        AudioService().getAudioServiceSettings(
          userSettings.isInGameMusicEnabled,
          userSettings.isGameSoundsEnabled,
        );
      }
      initObserver();
      initAudioService();
      isInSession = true;
    }

    initInGameMusic();
  }

  void initObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  void initAudioService() {
    AudioService().initAudioService();
  }

  void initInGameMusic() {
    if (isPlayingMusic) return;
    AudioService().playGameMusic();
    isPlayingMusic = true;
  }

  onGameScreenSelected(BuildContext context) {
    context.read<GameProvider>().initGameScreen();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notification = state;
    print(state);
    if (_notification == AppLifecycleState.resumed) {
      AudioService().playGameMusic();
    }
    if (_notification == AppLifecycleState.paused ||
        _notification == AppLifecycleState.hidden) {
      AudioService().pauseMusic();
    }
  }
}
