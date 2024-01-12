import 'package:flutter/material.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

import 'package:memory_game/injection_container.dart';
import 'package:memory_game/core/routes/app_router.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  AuthService.firebaseInit().then((value) {
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => sl<SplashProvider>()),
        ChangeNotifierProvider(create: (context) => sl<LogInProvider>()),
        ChangeNotifierProvider(create: (context) => sl<HomeProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GameProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GlobalScoresProvider>()),
      ], child: const MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Memory Game',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
