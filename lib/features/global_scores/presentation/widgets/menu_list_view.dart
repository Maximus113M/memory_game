import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/menu_model.dart';

import 'package:go_router/go_router.dart';

class MenuListView extends StatelessWidget {
  final List<MenuModel> menuList;

  const MenuListView({super.key, required this.menuList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menuList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => GoRouter.of(context).push(menuList[index].path),
        child: ListTile(
          minVerticalPadding: 15,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22),
          title: Text(menuList[index].title,
              style: FontStyles.subtitle1(AppColors.text)),
          subtitle: Text(
            menuList[index].subtitle,
            style: FontStyles.body2(AppColors.text),
          ),
          leading: Icon(
            menuList[index].icon,
            size: 26,
          ),
          trailing: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 26,
          ),
        ),
      ),
    );
  }
}
