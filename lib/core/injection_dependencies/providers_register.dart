import 'package:memory_game/features/local_scores/presentation/providers/local_scores_provider.dart';
import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';
import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';
import 'package:memory_game/features/global_scores/presentation/providers/global_scores_provider.dart';

void registerProviders() {
  sl.registerLazySingleton(
    () => SplashProvider(
      isUserSignInUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignInProvider(
      loginWithEmailAndPasswordUseCase: sl(),
      createWithEmailAndPasswordUseCase: sl(),
      verifyCurrentSessionUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => HomeProvider(firebaseAuth: sl()),
  );
  sl.registerLazySingleton(
    () => GameProvider(
      scoreDbRegisterUseCase: sl(),
      scoreLocalRegisterUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GlobalScoresProvider(
      getGlobalScoresUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LocalScoresProvider(
      getLocalScoresUseCase: sl(),
      clearLocalScoreUseCase: sl(),
    ),
  );
}
