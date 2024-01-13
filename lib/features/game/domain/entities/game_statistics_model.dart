class GameStatisticsModel {
  final int attempts;
  final int score;
  final String time;
  final int? timeBonus;
  final int? attemptsBonus;
  final int timeInSeconds; //TODO: POSIBLE ELIMINAR

  GameStatisticsModel({
    required this.attempts,
    required this.score,
    required this.time,
    required this.timeInSeconds,
    this.timeBonus = 0,
    this.attemptsBonus = 0,
  });
}
