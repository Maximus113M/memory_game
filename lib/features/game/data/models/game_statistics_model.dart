import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

class GameStatisticsModel {
  final int attempts;
  final int score;
  final String time;
  final GameDifficulty gameMode;
  final int? timeBonus;
  final int? attemptsBonus;

  GameStatisticsModel({
    required this.attempts,
    required this.score,
    required this.time,
    required this.gameMode,
    this.timeBonus = 0,
    this.attemptsBonus = 0,
  });
}