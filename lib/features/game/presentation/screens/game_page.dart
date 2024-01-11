import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/game/presentation/widgets/game_page_body.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  static const name = '/game';

  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Memory Game',
          style: FontStyles.subtitle2(AppColors.contrast),
        ),
        actions: [
          Icon(
            Icons.watch_later,
            color: AppColors.contrast,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Text(
              context.select(
                  (GameProvider gameProvider) => gameProvider.getTimeString()),
              style: FontStyles.body1(AppColors.contrast),
            ),
          ),
        ],
      ),
      body: GamePageBody(
        gameProvider: Provider.of<GameProvider>(context),
      ),
    );
  }
}
