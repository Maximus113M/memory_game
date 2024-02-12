import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

Widget basicMessageBody(String firstText, String secondText, IconData icon) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          firstText,
          style: FontStyles.body1(AppColors.contrast),
          overflow: TextOverflow.clip,
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(
            icon,
            color: AppColors.contrast,
            size: ScreenSize.absoluteHeight * 0.08,
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenSize.width * 0.04),
            child: SizedBox(
              width: ScreenSize.width * 0.47,
              child: Text(
                secondText,
                style: FontStyles.body1(AppColors.contrast),
                overflow: TextOverflow.clip,
              ),
            ),
          )
        ]),
      ],
    );

/*final Widget deleteLocalScoreMessageBody = Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      'Remember that you will not be able to recover the score records when they',
      style: FontStyles.body1(AppColors.contrast),
      overflow: TextOverflow.clip,
    ),
    Row(children: [
      Icon(
        Icons.warning,
        color: AppColors.contrast,
        size: ScreenSize.absoluteHeight * 0.08,
      ),
      Padding(
        padding: EdgeInsets.only(left: ScreenSize.width * 0.04),
        child: SizedBox(
          width: ScreenSize.width * 0.47,
          child: Text(
            'when they have been deleted, do you want to continue?',
            style: FontStyles.body1(AppColors.contrast),
            overflow: TextOverflow.clip,
          ),
        ),
      )
    ]),
  ],
);*/
