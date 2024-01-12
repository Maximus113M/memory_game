import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

class GlobalScoresListView extends StatelessWidget {
  final GlobalScoresProvider globalScoresProvider;
  final List<GlobalScoreEntity> globalScoreList;

  const GlobalScoresListView(
      {super.key,
      required this.globalScoresProvider,
      required this.globalScoreList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: globalScoreList.length,
      itemBuilder: (context, index) => ListTile(
          minVerticalPadding: 15,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22),
          title: Text(globalScoreList[index].userId.split('@')[0],
              style: FontStyles.subtitle1(AppColors.text)),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Time: ${globalScoreList[index].time}',
              style: FontStyles.body0(AppColors.text),
            ),
            const SizedBox(height: 3),
            Text(
              'Attempts: ${globalScoreList[index].attempts}',
              style: FontStyles.body0(AppColors.text),
            ),
            const SizedBox(height: 5),
            Text(
              'Score: ${globalScoreList[index].score}',
              style: FontStyles.subtitle1(AppColors.successText),
            ),
          ]),
          leading: Text(
            '${globalScoreList[index].rank}',
            style: FontStyles.heading4(AppColors.warning),
          )
          /*trailing: const Icon(
          Icons.arrow_circle_right_outlined,
          size: 26,
        ),*/
          ),
    );
  }
}
