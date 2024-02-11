import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomCloudDialog extends StatelessWidget {
  final Function() disableNotification;
  final Function() okOption;
  const CustomCloudDialog(
      {super.key, required this.disableNotification, required this.okOption});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: AppColors.text,
      title: Text(
        'Hey ${AuthService.userData!.name}!',
        style: FontStyles.subtitle0(AppColors.contrast),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Remember that if you want to compete with other players, you must activate',
            style: FontStyles.body1(AppColors.contrast),
            overflow: TextOverflow.clip,
          ),
          Row(children: [
            Icon(
              Icons.cloud,
              color: AppColors.contrast,
              size: ScreenSize.absoluteHeight * 0.08,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenSize.width * 0.04),
              child: SizedBox(
                width: ScreenSize.width * 0.47,
                child: Text(
                  '"Upload scores to the cloud" in the game settings in the main Menu.',
                  style: FontStyles.body1(AppColors.contrast),
                  overflow: TextOverflow.clip,
                ),
              ),
            )
          ]),
        ],
      ),
      actions: [
        CustomFilledButton(
          text: 'Don\'t Show Again',
          textStyle: FontStyles.body0(AppColors.contrast),
          onPress: () => disableNotification(),
          buttonColor: Colors.white10,
        ),
        CustomFilledButton(
          text: 'Ok',
          textStyle: FontStyles.body0(AppColors.contrast),
          onPress: () => okOption(),
          buttonColor: Colors.white10,
        ),
      ],
    );
  }
}
