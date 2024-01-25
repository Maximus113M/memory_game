import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/inputs/custom_text_form.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_button_icon.dart';

class CustomInputDialog extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final String message;
  final IconData inputIcon;
  final String hideText;
  final String actionButtonTitle;
  final IconData? actionButtonIcon;
  final int? inputMaxLength;
  final Function() actionButton;
  final Function(String value) getInputValue;

  const CustomInputDialog({
    super.key,
    required this.title,
    this.titleIcon,
    required this.message,
    required this.inputIcon,
    required this.hideText,
    required this.actionButtonTitle,
    this.actionButtonIcon,
    this.inputMaxLength,
    required this.actionButton,
    required this.getInputValue,
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
                  padding: const EdgeInsets.only(left: 2),
                  child: Icon(
                    titleIcon,
                    size: ScreenSize.width * 0.07,
                  ),
                ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: FontStyles.body1(AppColors.text),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenSize.height * 0.03,
            ),
            CustomTextForm(
              icon: inputIcon,
              text: hideText,
              onChange: (value) => getInputValue(value),
              error: false,
              maxTextLength: inputMaxLength,
            ),
            SizedBox(
              height: ScreenSize.height * 0.01,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.03),
      actions: [
        CustomFilledButtonIcon(
          icon: actionButtonIcon ?? Icons.save,
          text: actionButtonTitle,
          onPress: () => actionButton(),
          iconSize: 21,
          textSize: 18,
        ),
        CustomFilledButtonIcon(
          icon: Icons.close,
          text: 'Close',
          onPress: () => Navigator.pop(context),
          iconSize: 21,
          textSize: 18,
        ),
      ],
    );
  }
}
