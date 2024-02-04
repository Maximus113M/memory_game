import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/home/presentation/widgets/home_page_body.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const name = '/home';
  final HomeProvider homeProvider;

  const HomePage({super.key, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    homeProvider.initHome();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.text,
        elevation: 10,
        shadowColor: AppColors.text,
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
        actions: [
          IconButton(
              onPressed: () {
                homeProvider.signOut(context);
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.contrast,
                size: 28,
              ))
        ],
      ),
      body: HomePageBody(
        homeProvider: Provider.of<HomeProvider>(context),
      ),
    );
  }
}
