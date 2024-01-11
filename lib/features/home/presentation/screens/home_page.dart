import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/home/presentation/widgets/home_page_body.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const name = '/home';

  const HomePage({super.key});

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
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.contrast,
              radius: 22,
              child: Image.asset(AppAssets.brain),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Memory Game',
              style: FontStyles.subtitle2(AppColors.contrast),
            ),
          ],
        ),
      ),
      body: HomePageBody(
        homeProvider: Provider.of<HomeProvider>(context),
      ),
    );
  }
}
