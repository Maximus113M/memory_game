import 'package:flutter/material.dart';

class HomeMenuModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String path;

  HomeMenuModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });

  static List<HomeMenuModel> homeMenuList() => [
        HomeMenuModel(
          title: 'Play',
          subtitle: 'Play and test your skills!',
          icon: Icons.sports_esports,
          path: '/game',
        ),
        HomeMenuModel(
          title: 'High scores',
          subtitle: 'Check the record of your best scores!',
          icon: Icons.phone_android,
          path: '/local-scores',
        ),
        HomeMenuModel(
          title: 'Higher overall scores',
          subtitle: 'Check the world\'s 10 highest scores!',
          icon: Icons.public,
          path: '/global-scores',
        ),
        HomeMenuModel(
          title: 'Configuration',
          subtitle: 'Customize your game and account settings!',
          icon: Icons.settings_suggest_sharp,
          path: '/global-config',
        ),
      ];
}
