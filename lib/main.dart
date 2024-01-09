import 'package:flutter/material.dart';

import 'package:memory_game/config/routes/app_router.dart';
import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SplashProvider()),
      ChangeNotifierProvider(create: (context) => LogInProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
    ], child: const MyApp()),
  );
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
