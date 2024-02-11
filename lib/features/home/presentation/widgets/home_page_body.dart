import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/home/presentation/widgets/menu_option.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePageBody extends StatelessWidget {
  final HomeProvider homeProvider;

  const HomePageBody({super.key, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.04,
        horizontal: 4,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.61,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.read<HomeProvider>().isLocalList =
                homeProvider.menuList[index].isLocalList;

            if (homeProvider.menuList[index].path == '/game') {
              homeProvider.onGameScreenSelected(context);
            }
            GoRouter.of(context).push(homeProvider.menuList[index].path);
          },
          child: MenuOption(
            menuItem: homeProvider.menuList[index],
          ),
        );
      },
    );
  }
}
