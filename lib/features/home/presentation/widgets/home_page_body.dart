import 'package:flutter/material.dart';

import 'package:memory_game/features/home/presentation/widgets/menu_list_view.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

class HomePageBody extends StatelessWidget {
  final HomeProvider homeProvider;

  const HomePageBody({super.key, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    return MenuListView(menuList: homeProvider.menuList);
  }
}
