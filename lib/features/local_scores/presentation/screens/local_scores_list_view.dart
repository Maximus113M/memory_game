import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/local_scores/presentation/providers/local_scores_provider.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LocalScoresListView extends StatelessWidget {
  static const name = '/local-scores-view';

  const LocalScoresListView({
    super.key,
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
              'Local Scores',
              style: FontStyles.subtitle2(AppColors.contrast),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () =>
                  Provider.of<LocalScoresProvider>(context, listen: false)
                      .clearCurrentLocalScores(),
              icon: const Icon(
                Icons.auto_delete_outlined,
                color: AppColors.contrast,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: context.select((LocalScoresProvider localScoresProvider) =>
              localScoresProvider.isLoadingLocalScores)
          ? const MainLoading()
          : ScoreListView(
              scoreList: context.watch<LocalScoresProvider>().currentScoreList,
              textColor: AppColors.text,
            ),
    );
  }
}
