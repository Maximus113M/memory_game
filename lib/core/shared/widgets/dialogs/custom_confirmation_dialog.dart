import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final String message;
  final Function() mainAction;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    this.titleIcon,
    required this.message,
    required this.mainAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.contrast,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: FontStyles.heading9(AppColors.text),
              ),
              if (titleIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    titleIcon,
                    size: ScreenSize.width * 0.08,
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
            child: const Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.07),
        child: Text(
          message,
          style: FontStyles.body1(AppColors.lightText),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.04),
      actions: [
        CustomFilledButton(
          verticalPadding: 14,
          horizontalPadding: 23,
          text: 'Continue',
          onPress: () => mainAction(),
        ),
        CustomFilledButton(
          verticalPadding: 14,
          horizontalPadding: 30,
          text: 'Cancel',
          onPress: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
