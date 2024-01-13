class GlobalScoreEntity {
  final int attempts;
  final int rank;
  final int score;
  final int gameMode;
  final String userName;
  final String time;
  final String date;
  final String userId;

  GlobalScoreEntity({
    required this.attempts,
    required this.rank,
    required this.score,
    required this.userName,
    required this.time,
    required this.date,
    required this.gameMode,
    required this.userId,
  });

  factory GlobalScoreEntity.fromJson(json) => GlobalScoreEntity(
        attempts: json['attempts'],
        rank: json['rank'],
        score: json['score'],
        userName: json['user_name'],
        time: json['time'],
        date: json['date'],
        gameMode: json['game_mode'],
        userId: json['user_id'],
      );
}
