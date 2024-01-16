import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

class AppFunctions {
  static String getDateFormated() {
    final DateTime now = DateTime.now();
    return now.toString().split(' ')[0];
  }

  static int getDifficultyValue(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 1;
      case GameDifficulty.medium:
        return 2;
      case GameDifficulty.hard:
        return 3;
      default:
        return 0;
    }
  }

  static int getBaseGameScore({
    required GameDifficulty difficulty,
    required int attemptsCounter,
    required Duration duration,
  }) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return (3600 + (6 / attemptsCounter * 300 - duration.inSeconds * 79))
            .floor();

      case GameDifficulty.medium:
        return (3600 + (8 / attemptsCounter * 300 - duration.inSeconds * 99))
            .floor();

      case GameDifficulty.hard:
        return (3600 + (10 / attemptsCounter * 300 - duration.inSeconds * 130))
            .floor();

      default:
        return 0;
    }
  }

  static int getTimeBonus(
      {required GameDifficulty difficulty, required Duration duration}) {
    int timeBonus = 0;
    switch (difficulty) {
      case GameDifficulty.easy:
        if (duration.inSeconds <= 28) {
          timeBonus += 148;
          if (duration.inSeconds <= 16) {
            timeBonus += 148;
            if (duration.inSeconds <= 7) {
              timeBonus += 149;
            }
          }
        }
        return timeBonus;

      case GameDifficulty.medium:
        if (duration.inSeconds <= 23) {
          timeBonus += 181;
          if (duration.inSeconds <= 14) {
            timeBonus += 182;
            if (duration.inSeconds <= 9) {
              timeBonus += 182;
            }
          }
        }
        return timeBonus;

      case GameDifficulty.hard:
        if (duration.inSeconds <= 17) {
          timeBonus += 255;
          if (duration.inSeconds <= 13) {
            timeBonus += 255;
            if (duration.inSeconds <= 11) {
              timeBonus += 255;
            }
          }
        }
        return timeBonus;

      default:
        return timeBonus;
    }
  }

  static int getAttemptsBonus({
    required GameDifficulty difficulty,
    required int attemptsCounter,
  }) {
    int attemptsBonus = 0;
    switch (difficulty) {
      case GameDifficulty.easy:
        if (attemptsCounter <= 14) {
          attemptsBonus += 190;
          if (attemptsCounter <= 10) {
            attemptsBonus += 190;
            if (attemptsCounter <= 8) {
              attemptsBonus += 192;
              if (attemptsCounter <= 6) {
                attemptsBonus += 193;
              }
            }
          }
        }
        return attemptsBonus;

      case GameDifficulty.medium:
        if (attemptsCounter <= 14) {
          attemptsBonus += 134;
          if (attemptsCounter <= 12) {
            attemptsBonus += 136;
            if (attemptsCounter <= 10) {
              attemptsBonus += 137;
              if (attemptsCounter <= 8) {
                attemptsBonus += 138;
              }
            }
          }
        }
        return attemptsBonus;

      case GameDifficulty.hard:
        if (attemptsCounter <= 13) {
          attemptsBonus += 190;
          if (attemptsCounter <= 12) {
            attemptsBonus += 190;
            if (attemptsCounter <= 11) {
              attemptsBonus += 192;
              if (attemptsCounter <= 10) {
                attemptsBonus += 193;
              }
            }
          }
        }
        return attemptsBonus;

      default:
        return attemptsBonus;
    }
  }
}
