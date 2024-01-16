import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_config/presentation/providers/global_config_provider.dart';
import 'package:memory_game/features/global_config/presentation/widgets/game_mode_menu_list_tile.dart';

class GlobalConfigPageBody extends StatelessWidget {
  final GlobalConfigProvider globalConfigProvider;
  const GlobalConfigPageBody({super.key, required this.globalConfigProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenSize.height * 0.015,
          horizontal: ScreenSize.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Game Settings',
            style: FontStyles.subtitle0(AppColors.text),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenSize.width * 0.03),
            child: Text(
              'Game Mode',
              style: FontStyles.body0(AppColors.text),
            ),
          ),
          GameModeMenuListTile(
              currentValue: globalConfigProvider.currentGameMode,
              gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[0],
              onChanged: (value) => globalConfigProvider.selectGameMode(value)),
          GameModeMenuListTile(
            currentValue: globalConfigProvider.currentGameMode,
            gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[1],
            onChanged: (value) => globalConfigProvider.selectGameMode(value),
          ),
          GameModeMenuListTile(
            currentValue: globalConfigProvider.currentGameMode,
            gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[2],
            onChanged: (value) => globalConfigProvider.selectGameMode(value),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Account Settings',
            style: FontStyles.subtitle0(AppColors.text),
          ),
          const SizedBox(
            height: 5,
          ),
          accountOption('Update nickname', Icons.person),
          accountOption('Update email', Icons.mail),
          accountOption('Update password', Icons.key),
          accountOption('Delete Account', Icons.person_off),
        ],
      ),
    );
  }

  ListTile accountOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: FontStyles.body0(AppColors.text),
      ),
    );
  }
}
