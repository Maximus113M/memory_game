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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score Registration',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                          'You can give the record a name to make it easy to find or you can leave the default name.',
                          style: FontStyles.body0(AppColors.text),
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.05,
                        ),
                        CustomTextForm(
                          icon: Icons.sports_esports,
                          text: hideText,
                          onChange: (value) => setNameRecord(value),
                          error: false,
                          maxTextLength: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.08,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFilledButtonIcon(
                        icon: Icons.save,
                        text: 'Save',
                        onPress: () => saveGameScore(),
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
