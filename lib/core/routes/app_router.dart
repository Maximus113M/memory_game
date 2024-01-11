import 'package:memory_game/features/game/presentation/screens/game_page.dart';
import 'package:memory_game/features/home/presentation/screens/home_page.dart';
import 'package:memory_game/features/login/presentation/screens/log_in_page.dart';
import 'package:memory_game/features/login/presentation/screens/sign_up_page.dart';
import 'package:memory_game/features/splash/presentation/screens/splash_page.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: SplashPage.name,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: '/login',
    name: LogInPage.name,
    builder: (context, state) => const LogInPage(),
  ),
  GoRoute(
    path: '/sign-up',
    name: SignUpPage.name,
    builder: (context, state) => const SignUpPage(),
  ),
  GoRoute(
    path: '/home',
    name: HomePage.name,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/game',
    name: GamePage.name,
    builder: (context, state) => const GamePage(),
  ),
]);
