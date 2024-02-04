import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/core/services/auth_service.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_data_model.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

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
                Icon(
                  context.read<HomeProvider>().isLocalList
                      ? Icons.plagiarism
                      : Icons.travel_explore,
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
            itemBuilder: (context, index) => Flash(
              duration: const Duration(milliseconds: 2200),
              animate:
                  scoreList[index].userId == AuthService.currentUser!.uid &&
                      !context.read<HomeProvider>().isLocalList,
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: scoreList[index].userId ==
                                  AuthService.currentUser!.uid &&
                              !context.read<HomeProvider>().isLocalList
                          ? AppColors.winningScore
                          : AppColors.disabled.withOpacity(.9),
                      width: 3),
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
                        width: ScreenSize.width * 0.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            scoreDataRow(
                              scoreList[index].userName,
                              context.read<HomeProvider>().isLocalList
                                  ? Icons.description
                                  : Icons.person_pin,
                              textColor,
                              ScreenSize.width * 0.43,
                              isLocalList:
                                  context.read<HomeProvider>().isLocalList,
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
                                  "${scoreList[index].attempts} / ${context.read<GlobalScoresProvider>().minAttempts}",
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
            ),
          );
  }

  Column rankBody(int index) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              AppAssets.awardIcon,
              height: ScreenSize.absoluteHeight * 0.1,
            ),
            Text(
              '${index + 1}',
              style: FontStyles.heading3(
                      scoreList[index].userId == AuthService.currentUser!.uid
                          ? AppColors.winningScore
                          : AppColors.text)
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
            scoreList[index].date.toString().split(' ')[0],
            style: FontStyles.body4(AppColors.contrast),
          ),
        )
      ],
    );
  }

  Row scoreDataRow(String text, IconData icon, Color color, double width,
      {bool? isLocalList}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 28,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: Text(
            text,
            style: FontStyles.bodyBold1(color),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
