import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

class GameStatisticsModel {
  final int attempts;
  final int score;
  final String time;
  final GameDifficulty gameMode;
  final int? timeBonus;
  final int? attemptsBonus;
  final String? recordName;

  GameStatisticsModel({
    required this.attempts,
    required this.score,
    required this.time,
    required this.gameMode,
    this.recordName,
    this.timeBonus = 0,
    this.attemptsBonus = 0,
  });
}
