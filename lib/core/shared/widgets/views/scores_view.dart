import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_scores/domain/entities/global_score_entity.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

class ScoresView extends StatelessWidget {
  static const name = '/scores-view';
  final GlobalScoresProvider globalScoresProvider;
  //final List<GlobalScoreEntity> globalScoreList;

  const ScoresView({
    super.key,
    required this.globalScoresProvider,
    //required this.globalScoreList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: AppColors.text,
        backgroundColor: AppColors.text,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.contrast,
          ),
        ),
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.public,
                color: AppColors.contrast,
              ),
            ),
            Text(
              'Global Scores',
              style: FontStyles.subtitle2(AppColors.contrast),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: globalScoresProvider.selectScoreList().length,
        itemBuilder: (context, index) => ListTile(
            minVerticalPadding: 15,
            contentPadding: const EdgeInsets.symmetric(horizontal: 22),
            title: Text(
                globalScoresProvider
                    .selectScoreList()[index]
                    .userId
                    .split('@')[0],
                style: FontStyles.subtitle1(AppColors.text)),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Time: ${globalScoresProvider.selectScoreList()[index].time}',
                style: FontStyles.body0(AppColors.text),
              ),
              const SizedBox(height: 3),
              Text(
                'Attempts: ${globalScoresProvider.selectScoreList()[index].attempts}',
                style: FontStyles.body0(AppColors.text),
              ),
              const SizedBox(height: 5),
              Text(
                'Score: ${globalScoresProvider.selectScoreList()[index].score}',
                style: FontStyles.subtitle1(AppColors.successText),
              ),
            ]),
            leading: Text(
              '${globalScoresProvider.selectScoreList()[index].rank}',
              style: FontStyles.heading4(AppColors.warning),
            )
            /*trailing: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 26,
              ),*/
            ),
      ),
    );
    /*Column(
      children: [
        Text('Hola'),
        SizedBox(
          height: ScreenSize.height * 0.6,
          child: 
        ),
      ],
    );*/
  }
}
