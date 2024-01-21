import 'package:flutter/material.dart';
import 'package:memory_game/features/global_config/presentation/providers/global_config_provider.dart';

import 'package:memory_game/injection_container.dart';
import 'package:memory_game/core/routes/app_router.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';
import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';
import 'package:memory_game/features/local_scores/presentation/providers/local_scores_provider.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  AuthService.firebaseInit().then((value) {
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => sl<SplashProvider>()),
        ChangeNotifierProvider(create: (context) => sl<SignInProvider>()),
        ChangeNotifierProvider(create: (context) => sl<HomeProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GameProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GlobalScoresProvider>()),
        ChangeNotifierProvider(create: (context) => sl<LocalScoresProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GlobalConfigProvider>()),
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 88, 34, 182)),
        useMaterial3: true,
      ),
    );
  }
}
