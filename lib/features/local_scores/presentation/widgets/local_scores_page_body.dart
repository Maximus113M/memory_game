import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/menus/menu_card.dart';
import 'package:memory_game/core/shared/models/scores_menu_model.dart';
import 'package:memory_game/features/local_scores/presentation/providers/local_scores_provider.dart';

class LocalScoresPageBody extends StatelessWidget {
  final LocalScoresProvider localScoresProvider;
  final List<ScoreMenuModel> scoreMenuList;
  const LocalScoresPageBody({
    super.key,
    required this.scoreMenuList,
    required this.localScoresProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Image.asset(
            AppAssets.podio,
            height: ScreenSize.height * 0.19,
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.65,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: scoreMenuList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => localScoresProvider.goToScoresListView(
                    context, scoreMenuList[index].difficultyValue),
                child: MenuCard(
                  difficultyValue: scoreMenuList[index].difficultyValue,
                  backgroundColor: scoreMenuList[index].backgroundColor!,
                  difficultyName: scoreMenuList[index].difficultyName,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}