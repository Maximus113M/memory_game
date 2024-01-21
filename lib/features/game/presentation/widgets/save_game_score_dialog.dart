import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/inputs/custom_text_form.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_button_icon.dart';

class SaveGameScoreDialog extends StatelessWidget {
  final String hideText;
  final Function() saveGameScore;
  final Function(String value) setNameRecord;

  const SaveGameScoreDialog(
      {super.key,
      required this.saveGameScore,
      required this.setNameRecord,
      required this.hideText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.contrast,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Score Registration',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.verified,
                  size: 26,
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.06),
            child: Text(
              'You can give the record a name to make it easy to find or you can leave the default name.',
              style: FontStyles.body0(AppColors.text),
            ),
          ),
          SizedBox(
            height: ScreenSize.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.03,
            ),
            child: CustomTextForm(
              icon: Icons.sports_esports,
              text: hideText,
              onChange: (value) => setNameRecord(value),
              error: false,
              maxTextLength: 20,
            ),
          )
        ],
      ),
      actionsPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.04),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomFilledButtonIcon(
          icon: Icons.save,
          text: 'Save',
          onPress: () => saveGameScore(),
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
