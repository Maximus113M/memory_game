import 'package:flutter/material.dart';

import 'package:memory_game/config/utils/constanst/screen_size.dart';
import 'package:memory_game/features/home/presentation/widgets/home_body.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const name = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: HomeBody(homeProvider: Provider.of<HomeProvider>(context)),
    );
  }
}
