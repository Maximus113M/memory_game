import 'package:flutter/material.dart';

import 'package:memory_game/config/utils/constanst/screen_size.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';
import 'package:memory_game/features/splash/presentation/widgets/splash_body.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  static const name = 'splash';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: SplashBody(splashProvider: Provider.of<SplashProvider>(context)),
    );
  }
}
