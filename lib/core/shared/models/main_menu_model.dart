import 'package:flutter/material.dart';

class MainMenuModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String path;

  MainMenuModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  static List<MainMenuModel> mainMenuList() => [
        MainMenuModel(
          title: 'Play',
          subtitle: 'Play and test your skills!',
          icon: Icons.sports_esports,
          path: '/game',
        ),
        MainMenuModel(
          title: 'High scores',
          subtitle: 'Check your high scores!',
          icon: Icons.phone_android,
          path: '/local-scores',
        ),
        MainMenuModel(
          title: 'Higher overall scores',
          subtitle: 'Check the world\'s 10 highest scores!',
          icon: Icons.public,
          path: '/global-scores',
        ),
      ];
}
