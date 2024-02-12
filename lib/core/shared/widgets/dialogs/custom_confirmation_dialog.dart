import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final String message;
  final Function() mainAction;
  final Function()? secundaryAction;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    this.titleIcon,
    required this.message,
    required this.mainAction,
    this.secundaryAction,
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
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
            child: const Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1),
      content: Text(
        message,
        style: FontStyles.body1(AppColors.lightText),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.03),
      actions: [
        CustomFilledButton(
          verticalPadding: 14,
          horizontalPadding: 25,
          text: 'Cancel',
          onPress: () =>
              secundaryAction != null ? secundaryAction!() : context.pop(),
          textStyle: FontStyles.bodyBold0(AppColors.contrast),
        ),
        CustomFilledButton(
          verticalPadding: 14,
          horizontalPadding: 18,
          text: 'Continue',
          onPress: () => mainAction(),
          textStyle: FontStyles.bodyBold0(AppColors.contrast),
        ),
      ],
    );
  }
}
