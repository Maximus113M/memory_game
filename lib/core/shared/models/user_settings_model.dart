import 'package:isar/isar.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';
part 'user_settings_model.g.dart';

@collection
class UserSettingsModel {
  Id? id;

  final String userId;
  int memorizingTime;
  bool isCloudEnabled;
  bool isInGameMusicEnabled;
  bool isGameSoundsEnabled;
  @enumerated
  GameDifficulty gameMode;

  UserSettingsModel({
    required this.userId,
    this.gameMode = GameDifficulty.easy,
    this.memorizingTime = 5,
    this.isCloudEnabled = false,
    this.isInGameMusicEnabled = true,
    this.isGameSoundsEnabled = true,
  });

  void updateUserSettings(UserSettingsModel newUserSettings) {
    gameMode = newUserSettings.gameMode;
    memorizingTime = newUserSettings.memorizingTime;
    isCloudEnabled = newUserSettings.isCloudEnabled;
    isInGameMusicEnabled = newUserSettings.isInGameMusicEnabled;
    isGameSoundsEnabled = newUserSettings.isGameSoundsEnabled;
  }
}
