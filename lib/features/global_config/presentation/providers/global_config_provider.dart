import 'package:flutter/material.dart';

import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

class GlobalConfigProvider with ChangeNotifier {
  final List<GameModeMenuOptions> gameModeMenuOptions =
      GameModeMenuOptions.gameModeMenuList;
  GameDifficulty currentGameMode = GameDifficulty.easy;

  GlobalConfigProvider();

  void selectGameMode(GameDifficulty selectedtGameMode) {
    currentGameMode = selectedtGameMode;
    notifyListeners();
  }
}
