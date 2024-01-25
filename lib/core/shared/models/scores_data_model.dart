import 'package:isar/isar.dart';

part 'scores_data_model.g.dart';

@collection
class ScoresDataModel {
  Id? id;

  final String userId;
  final String userName;
  final int attempts;
  final int score;
  final int gameMode;
  int ranking;
  final String time;
  final DateTime date;

  ScoresDataModel({
    required this.userId,
    required this.userName,
    required this.attempts,
    required this.score,
    required this.gameMode,
    required this.ranking,
    required this.time,
    required this.date,
  });

  factory ScoresDataModel.fromJson(json) => ScoresDataModel(
        userId: json['user_id'],
        userName: json['user_name'],
        gameMode: json['game_mode'],
        attempts: json['attempts'],
        score: json['score'],
        ranking: json['ranking'],
        time: json['time'],
        date: json['date'].toDate(),
      );

  Map<String, dynamic> scoresDataModelToJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "game_mode": gameMode,
      "attempts": attempts,
      "score": score,
      "ranking": ranking,
      "time": time,
      "date": date,
    };
  }
}
