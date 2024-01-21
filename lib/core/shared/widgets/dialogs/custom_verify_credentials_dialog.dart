import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/inputs/custom_text_form.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_button_icon.dart';

class CustomVerifyCredentialsDialog extends StatelessWidget {
  final int? inputMaxLength;
  final Function() actionButton;
  final Function(String value) getInputValue;

  const CustomVerifyCredentialsDialog({
    super.key,
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
                'Verify Credentials',
                style: FontStyles.heading9(AppColors.text),
              ),
              Icon(
                Icons.verified_user,
                size: ScreenSize.width * 0.07,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please, enter your password to verify your identity :)',
              style: FontStyles.body1(AppColors.text),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenSize.height * 0.03,
                  bottom: ScreenSize.height * 0.01),
              child: CustomTextForm(
                icon: Icons.lock,
                text: 'Password',
                onChange: (value) => getInputValue(value),
                isHiden: true,
                error: false,
                maxTextLength: inputMaxLength,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.03),
      actions: [
        CustomFilledButtonIcon(
          icon: Icons.verified_outlined,
          text: 'Verify',
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
