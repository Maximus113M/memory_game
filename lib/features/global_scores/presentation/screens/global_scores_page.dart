import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_scores/presentation/widgets/global_scores_page_body.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class GlobalScoresPage extends StatelessWidget {
  static const name = '/global-scores';

  const GlobalScoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((GlobalScoresProvider globalScoreProvider) =>
        globalScoreProvider.getGlobalScores(context));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.text,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.contrast,
          ),
        ),
        title: Text(
          'Global Scores',
          style: FontStyles.subtitle2(AppColors.contrast),
        ),
      ),
      body: const GlobalScoresPageBody(),
    );
  }
}
