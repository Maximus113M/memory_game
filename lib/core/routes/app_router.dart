import 'package:go_router/go_router.dart';
import 'package:memory_game/features/home/presentation/screens/home_page.dart';
import 'package:memory_game/features/login/presentation/screens/log_in_page.dart';
import 'package:memory_game/features/splash/presentation/screens/splash_page.dart';

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
    path: '/home',
    name: HomePage.name,
    builder: (context, state) => const HomePage(),
  ),
]);
