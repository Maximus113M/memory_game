import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_config/presentation/providers/global_config_provider.dart';
import 'package:memory_game/features/global_config/presentation/widgets/game_mode_menu_list_tile.dart';

class GlobalConfigPageBody extends StatelessWidget {
  final GlobalConfigProvider globalConfigProvider;
  const GlobalConfigPageBody({super.key, required this.globalConfigProvider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenSize.width * 0.03,
                  top: ScreenSize.height * 0.005),
              child: headerTitle('Game Mode'),
            ),
            GameModeMenuListTile(
              currentValue: globalConfigProvider.currentGameMode,
              gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[0],
              onChanged: (value) =>
                  globalConfigProvider.selectGameMode(context, value),
            ),
            GameModeMenuListTile(
              currentValue: globalConfigProvider.currentGameMode,
              gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[1],
              onChanged: (value) =>
                  globalConfigProvider.selectGameMode(context, value),
            ),
            GameModeMenuListTile(
              currentValue: globalConfigProvider.currentGameMode,
              gameModeMenuItem: globalConfigProvider.gameModeMenuOptions[2],
              onChanged: (value) =>
                  globalConfigProvider.selectGameMode(context, value),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenSize.width * 0.03,
                top: ScreenSize.height * 0.01,
                right: ScreenSize.width * 0.07,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerTitle('Memorizing Time'),
                  description(
                      'You can set the default memorizing time between 3 and 10 seconds. You will receive an additional time bonus if the countdown is 5 seconds or less.'),
                  Padding(
                    padding: EdgeInsets.only(right: ScreenSize.width * 0.01),
                    child: Slider.adaptive(
                      activeColor: Colors.amber.shade700,
                      value: globalConfigProvider.memorizingTime.toDouble(),
                      onChanged: (value) => globalConfigProvider
                          .setMemorizingTime(context, value.floor()),
                      divisions: 10,
                      min: 0,
                      max: 10,
                      label: '${globalConfigProvider.memorizingTime}s',
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.01,
                  ),
                  headerTitle('Upload game score to the cloud'),
                  Row(
                    children: [
                      SizedBox(
                        width: ScreenSize.width * 0.61,
                        child: description(
                          'Do you want that when you record the score of a game, you can upload it to the cloud and compete with players from all over the world?',
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.04),
                      Switch(
                        activeColor: Colors.amber.shade700,
                        value: globalConfigProvider.isCloudEnable,
                        onChanged: (value) =>
                            globalConfigProvider.setCloudUpload(context, value),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.03,
                  ),
                  headerTitle('Game Sounds'),
                  SizedBox(
                    width: ScreenSize.width * 0.7,
                    child: description(
                      'Activate or deactivate the game sounds of your choice.',
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * 0.04),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    leading: const Icon(Icons.music_note),
                    title: Text(
                      "In-Game music",
                      style: FontStyles.body1(AppColors.text),
                    ),
                    trailing: Checkbox(
                      activeColor: Colors.amber.shade700,
                      value: globalConfigProvider.isInGameMusicEnabled,
                      onChanged: (value) =>
                          globalConfigProvider.setInGameMusic(context, value!),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    leading: const Icon(Icons.volume_up),
                    title: Text(
                      "Game sound effects",
                      style: FontStyles.body1(AppColors.text),
                      maxLines: 2,
                    ),
                    trailing: Checkbox(
                      activeColor: Colors.amber.shade700,
                      value: globalConfigProvider.isGameSoundsEnabled,
                      onChanged: (value) =>
                          globalConfigProvider.setGameSounds(value!),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Account Settings',
                    style: FontStyles.subtitle0(AppColors.text),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  accountOption(
                    'Update nickname',
                    Icons.person,
                    () => globalConfigProvider.verifyCredentialsDialog(
                        context, AccountOption.updateName),
                  ),
                  accountOption(
                      'Update email',
                      Icons.mail,
                      () => globalConfigProvider.verifyCredentialsDialog(
                          context, AccountOption.updateEmail)),
                  accountOption('Update password', Icons.key,
                      () => globalConfigProvider.loadingDialog(context)),
                  accountOption(
                      'Delete Account',
                      Icons.person_off,
                      () => globalConfigProvider.verifyCredentialsDialog(
                          context, AccountOption.deleteAccount)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text headerTitle(String title) {
    return Text(
      title,
      style: FontStyles.bodyBold0(AppColors.text),
    );
  }

  Padding description(String description) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenSize.width * 0.017,
        top: ScreenSize.height * 0.006,
      ),
      child: Text(
        description,
      ),
    );
  }

  ListTile accountOption(
      String title, IconData icon, Function() accountAction) {
    return ListTile(
      onTap: () => accountAction(),
      leading: Icon(icon),
      title: Text(
        title,
        style: FontStyles.body0(AppColors.text),
      ),
    );
  }
}
