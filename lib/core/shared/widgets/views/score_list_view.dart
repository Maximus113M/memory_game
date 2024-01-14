import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';

class ScoreListView extends StatelessWidget {
  final List<ScoresDataModel> scoreList;
  final Color textColor;
  const ScoreListView({
    super.key,
    required this.scoreList,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return scoreList.isEmpty
        ? Center(
            heightFactor: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.travel_explore,
                  size: 150,
                  color: AppColors.backgroundBase,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No record has been found..',
                  style: FontStyles.heading10(AppColors.backgroundBase),
                )
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemCount: scoreList.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.disabled.withOpacity(.9), width: 3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: AppColors.contrast,
                boxShadow: AppShadows.mainShadow,
              ),
              child: Row(
                children: [
                  rankBody(index),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: ScreenSize.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreDataRow(
                            scoreList[index].userName,
                            Icons.person,
                            textColor,
                            ScreenSize.width * 0.41,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              scoreDataRow(
                                scoreList[index].time,
                                Icons.hourglass_bottom,
                                textColor,
                                ScreenSize.width * 0.2,
                              ),
                              SizedBox(
                                width: ScreenSize.height * 0.02,
                              ),
                              scoreDataRow(
                                "${scoreList[index].attempts}",
                                Icons.move_up_sharp,
                                textColor,
                                ScreenSize.width * 0.2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          scoreDataRow(
                            "${scoreList[index].score}",
                            Icons.emoji_events,
                            Colors.amber,
                            ScreenSize.width * 0.3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Column rankBody(int index) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(AppAssets.awardIcon),
            Text(
              '${scoreList[index].rank}',
              style: FontStyles.heading1(AppColors.text)
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: AppColors.text),
          child: Text(
            scoreList[index].date,
            style: FontStyles.bodyBold3(AppColors.contrast),
          ),
        )
      ],
    );
  }

  Row scoreDataRow(String text, IconData icon, Color color, double width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 30,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: Text(
            text,
            style: FontStyles.subtitle1(color),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
