// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/models/scores_menu_model.dart';
import 'package:memory_game/features/local_scores/presentation/widgets/local_scores_page_body.dart';
import 'package:memory_game/features/local_scores/presentation/providers/local_scores_provider.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LocalScoresPage extends StatelessWidget {
  static const name = '/local-scores';

  const LocalScoresPage({super.key});

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
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: const Icon(
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
      ),
      body: LocalScoresPageBody(
        scoreMenuList: ScoreMenuModel.scoreMenuList(),
        localScoresProvider: Provider.of<LocalScoresProvider>(context),
      ),
    );
  }
}
