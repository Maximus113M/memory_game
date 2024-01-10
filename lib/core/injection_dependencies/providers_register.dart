import 'package:memory_game/features/home/presentation/providers/home_provider.dart';
import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/splash/presentation/providers/splash_provider.dart';
import 'package:memory_game/injection_container.dart';

void registerProviders() {
  sl.registerLazySingleton(
    () => SplashProvider(),
  );
  sl.registerLazySingleton(
    () => LogInProvider(
      loginWithEmailAndPasswordUseCase: sl(),
      createWithEmailAndPasswordUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => HomeProvider(),
  );
}
