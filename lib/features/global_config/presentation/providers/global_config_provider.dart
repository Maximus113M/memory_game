import 'package:flutter/material.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';

import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';
import 'package:provider/provider.dart';

class GlobalConfigProvider with ChangeNotifier {
  final List<GameModeMenuOptions> gameModeMenuOptions =
      GameModeMenuOptions.gameModeMenuList;
  GameDifficulty currentGameMode = GameDifficulty.easy;

  GlobalConfigProvider();

  void selectGameMode(BuildContext context, GameDifficulty selectedtGameMode) {
    currentGameMode = selectedtGameMode;
    Provider.of<GameProvider>(context, listen: false)
        .getGameMode(currentGameMode);

    notifyListeners();
  }
}
