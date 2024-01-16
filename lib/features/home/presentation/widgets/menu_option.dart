import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/home_menu_model.dart';

class MenuOption extends StatelessWidget {
  final HomeMenuModel menuItem;

  const MenuOption({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.disabled.withOpacity(0.7), width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.mainShadow,
        color: AppColors.text,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ScreenSize.height * 0.03,
          ),
          Icon(
            menuItem.icon,
            size: 85,
            color: AppColors.contrast,
          ),
          SizedBox(
            height: ScreenSize.height * 0.04,
          ),
          SizedBox(
            height: 120,
            child: Column(
              children: [
                Text(
                  menuItem.title,
                  style: FontStyles.heading11(AppColors.contrast),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  menuItem.subtitle,
                  style: FontStyles.body1(AppColors.contrast),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
