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
  final String time;
  final String date;
  int rank;

  ScoresDataModel({
    required this.userId,
    required this.userName,
    required this.attempts,
    required this.rank,
    required this.score,
    required this.time,
    required this.date,
    required this.gameMode,
  });

  void incrementRank() {
    rank++;
  }

  factory ScoresDataModel.fromJson(json) => ScoresDataModel(
        userId: json['user_id'],
        userName: json['user_name'],
        gameMode: json['game_mode'],
        attempts: json['attempts'],
        rank: json['rank'],
        score: json['score'],
        time: json['time'],
        date: json['date'],
      );

  Map<String, dynamic> scoresDataModelToJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "game_mode": gameMode,
      "attempts": attempts,
      "rank": rank,
      "score": score,
      "time": time,
      "date": date,
    };
  }
}
