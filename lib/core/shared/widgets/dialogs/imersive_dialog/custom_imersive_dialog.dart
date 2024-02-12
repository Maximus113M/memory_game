import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomImersiveDialog extends StatelessWidget {
  final String disableOptionTitle;
  final String? okOptionTitle;
  final Widget contentBody;
  final Function() disableOption;
  final Function() okOption;

  const CustomImersiveDialog({
    super.key,
    required this.disableOptionTitle,
    required this.contentBody,
    required this.disableOption,
    required this.okOption,
    this.okOptionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        //surfaceTintColor: AppColors.text,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Hey ${AuthService.userData!.name}!',
          style: FontStyles.subtitle0(AppColors.contrast),
          textAlign: TextAlign.center,
        ),
        content: contentBody,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CustomFilledButton(
            text: disableOptionTitle,
            textStyle: FontStyles.body0(AppColors.contrast),
            onPress: () => disableOption(),
            buttonColor: Colors.white10,
          ),
          CustomFilledButton(
            text: okOptionTitle ?? 'Ok',
            textStyle: FontStyles.body0(AppColors.contrast),
            onPress: () => okOption(),
            buttonColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}
