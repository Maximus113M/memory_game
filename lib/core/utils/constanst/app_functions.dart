import 'dart:math';

import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';

class AppFunctions {
  static String getDateFormated() {
    final DateTime now = DateTime.now();
    return now.toString().split(' ')[0];
  }

  static int getRandomNumber(int limit) {
    return Random().nextInt(limit);
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
    required Duration time,
    required int countdownTime,
  }) {
    double breach = 1;
    int countdownBonus = getCountDownBonus(countdownTime);

    switch (difficulty) {
      case GameDifficulty.easy:
        if (time.inSeconds > 25) {
          breach = time.inSeconds / 25;
        }
        return (2892 -
                ((attemptsCounter - 6) * 80 + time.inSeconds * 32 * breach) +
                countdownBonus)
            .floor();

      case GameDifficulty.medium:
        if (time.inSeconds > 16) {
          breach = time.inSeconds / 16;
        }
        return (2972 -
                ((attemptsCounter - 8) * 90 + time.inSeconds * 34 * breach) +
                countdownBonus)
            .floor();

      case GameDifficulty.hard:
        if (time.inSeconds > 10) {
          breach = time.inSeconds / 10;
        }
        return (3050 +
                ((attemptsCounter - 10) * 110 - time.inSeconds * 35 * breach) +
                countdownBonus)
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
          timeBonus += 200;
          if (duration.inSeconds <= 16) {
            timeBonus += 200;
            if (duration.inSeconds <= 7) {
              timeBonus += 200;
            }
          }
        }
        return timeBonus;

      case GameDifficulty.medium:
        if (duration.inSeconds <= 23) {
          timeBonus += 200;
          if (duration.inSeconds <= 14) {
            timeBonus += 200;
            if (duration.inSeconds <= 9) {
              timeBonus += 200;
            }
          }
        }
        return timeBonus;

      case GameDifficulty.hard:
        if (duration.inSeconds <= 17) {
          timeBonus += 200;
          if (duration.inSeconds <= 13) {
            timeBonus += 200;
            if (duration.inSeconds <= 11) {
              timeBonus += 200;
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
          attemptsBonus += 200;
          if (attemptsCounter <= 10) {
            attemptsBonus += 200;
            if (attemptsCounter <= 8) {
              attemptsBonus += 200;
              if (attemptsCounter <= 6) {
                attemptsBonus += 200;
              }
            }
          }
        }
        return attemptsBonus;

      case GameDifficulty.medium:
        if (attemptsCounter <= 14) {
          attemptsBonus += 200;
          if (attemptsCounter <= 12) {
            attemptsBonus += 200;
            if (attemptsCounter <= 10) {
              attemptsBonus += 200;
              if (attemptsCounter <= 8) {
                attemptsBonus += 200;
              }
            }
          }
        }
        return attemptsBonus;

      case GameDifficulty.hard:
        if (attemptsCounter <= 13) {
          attemptsBonus += 200;
          if (attemptsCounter <= 12) {
            attemptsBonus += 200;
            if (attemptsCounter <= 11) {
              attemptsBonus += 200;
              if (attemptsCounter <= 10) {
                attemptsBonus += 200;
              }
            }
          }
        }
        return attemptsBonus;

      default:
        return attemptsBonus;
    }
  }

  static int getCountDownBonus(int countdownTime) {
    switch (countdownTime) {
      case 3:
        return 900;
      case 4:
        return 600;
      case 5:
        return 300;
      default:
        return 0;
    }
  }
}
