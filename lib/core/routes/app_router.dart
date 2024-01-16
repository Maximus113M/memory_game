import 'package:memory_game/features/global_config/presentation/screens/global_config_page.dart';
import 'package:memory_game/features/global_scores/presentation/screens/global_scores_list_view.dart';
import 'package:memory_game/features/local_scores/presentation/screens/local_scores_list_view.dart';
import 'package:memory_game/features/local_scores/presentation/screens/local_scores_page.dart';
import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/game/presentation/screens/game_page.dart';
import 'package:memory_game/features/home/presentation/screens/home_page.dart';
import 'package:memory_game/features/sign_in/presentation/screens/log_in_page.dart';
import 'package:memory_game/features/sign_in/presentation/screens/sign_up_page.dart';
import 'package:memory_game/features/splash/presentation/screens/splash_page.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/global_scores/presentation/screens/global_scores_page.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
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
      builder: (context, state) => HomePage(homeProvider: sl<HomeProvider>()),
    ),
    GoRoute(
      path: '/game',
      name: GamePage.name,
      builder: (context, state) => GamePage(
        gameProvider: sl<GameProvider>(),
      ),
    ),
    GoRoute(
      path: '/global-scores',
      name: GlobalScoresPage.name,
      builder: (context, state) => const GlobalScoresPage(),
    ),
    GoRoute(
      path: '/global-scores-view',
      name: GlobalScoresListView.name,
      builder: (context, state) => const GlobalScoresListView(),
    ),
    GoRoute(
      path: '/local-scores',
      name: LocalScoresPage.name,
      builder: (context, state) => const LocalScoresPage(),
    ),
    GoRoute(
      path: '/local-scores-view',
      name: LocalScoresListView.name,
      builder: (context, state) => const LocalScoresListView(),
    ),
    GoRoute(
      path: '/global-config',
      name: GlobalConfigPage.name,
      builder: (context, state) => const GlobalConfigPage(),
    ),
  ],
);
