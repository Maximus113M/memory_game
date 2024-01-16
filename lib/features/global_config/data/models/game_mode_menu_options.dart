class GameModeMenuOptions {
  final String title;
  final String subtitle;
  final GameDifficulty gameMode;

  GameModeMenuOptions({
    required this.title,
    required this.subtitle,
    required this.gameMode,
  });

  static List<GameModeMenuOptions> gameModeMenuList = [
    GameModeMenuOptions(
        title: 'Easy',
        subtitle: 'Enjoy a smooth game. Recommended for beginners.',
        gameMode: GameDifficulty.easy),
    GameModeMenuOptions(
        title: 'Medium',
        subtitle: 'Enjoy a balanced game. Recommended for the general public.',
        gameMode: GameDifficulty.medium),
    GameModeMenuOptions(
        title: 'Hard',
        subtitle: 'Enjoy a demanding game. Recommended for experienced users.',
        gameMode: GameDifficulty.hard),
  ];
}

enum GameDifficulty { easy, medium, hard }
