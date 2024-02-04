import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

class GameModeMenuListTile extends StatelessWidget {
  final GameDifficulty currentValue;
  final GameModeMenuOptions gameModeMenuItem;
  final Function(dynamic value) onChanged;
  const GameModeMenuListTile({
    super.key,
    required this.currentValue,
    required this.gameModeMenuItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.label),
      title: Text(
        gameModeMenuItem.title,
        style: FontStyles.bodyBold0(AppColors.text),
      ),
      subtitle: Text(gameModeMenuItem.subtitle),
      trailing: Radio(
        activeColor: Colors.amber.shade700,
        groupValue: currentValue,
        value: gameModeMenuItem.gameMode,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
