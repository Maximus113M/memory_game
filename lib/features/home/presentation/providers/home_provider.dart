import 'package:flutter/material.dart';
import 'package:memory_game/core/shared/models/menu_model.dart';

class HomeProvider with ChangeNotifier {
  List<MenuModel> menuList = [
    MenuModel(
      title: 'Play',
      subtitle: 'Play and test your skills!',
      icon: Icons.sports_esports,
      path: '/game',
    ),
    MenuModel(
      title: 'High scores',
      subtitle: 'Check your high scores!',
      icon: Icons.phone_android,
      path: '/local-scores',
    ),
    MenuModel(
      title: 'Higher overall scores',
      subtitle: 'Check the world\'s 10 highest scores!',
      icon: Icons.public,
      path: '/global-scores',
    ),
  ];

  HomeProvider();
}
