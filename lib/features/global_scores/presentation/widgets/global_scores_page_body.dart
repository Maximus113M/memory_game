import 'package:flutter/material.dart';

import 'package:memory_game/features/global_scores/presentation/widgets/global_scores_list_view.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';
import 'package:provider/provider.dart';

class GlobalScoresPageBody extends StatelessWidget {
  const GlobalScoresPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScoresListView(
      globalScoresProvider: Provider.of<GlobalScoresProvider>(context),
      globalScoreList:
          Provider.of<GlobalScoresProvider>(context).selectScoreList(),
    );
  }
}
