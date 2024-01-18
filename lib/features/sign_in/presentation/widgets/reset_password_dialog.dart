import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/inputs/custom_text_form.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_button_icon.dart';

class ResetPasswordDialog extends StatelessWidget {
  final String hideText;
  final Function() sendConfirmation;
  final Function(String value) setEmail;

  const ResetPasswordDialog(
      {super.key,
      required this.sendConfirmation,
      required this.setEmail,
      required this.hideText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.15),
        child: Dialog(
          surfaceTintColor: AppColors.contrast,
          child: SizedBox(
            height: ScreenSize.height * 0.52,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: ScreenSize.width * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'It looks like you have not memorized your password, don\'t worry, you can reset it. Please, enter your registered email address.',
                          style: FontStyles.body0(AppColors.text),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.05,
                        ),
                        CustomTextForm(
                          icon: Icons.email_outlined,
                          text: hideText,
                          onChange: (value) => setEmail(value),
                          error: false,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.065,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFilledButtonIcon(
                        icon: Icons.send,
                        text: 'Send',
                        onPress: () => sendConfirmation(),
                        iconSize: 22,
                        textSize: 18,
                      ),
                      SizedBox(width: ScreenSize.width * 0.02),
                      CustomFilledButtonIcon(
                        icon: Icons.close,
                        text: 'Close',
                        onPress: () => Navigator.pop(context),
                        iconSize: 22,
                        textSize: 18,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
