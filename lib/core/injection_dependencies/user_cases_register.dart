import 'package:memory_game/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:memory_game/features/login/domain/use_cases/create_with_email_and_password_use_case.dart';
import 'package:memory_game/features/global_scores/domain/use_cases/get_global_scores_use_case.dart';
import 'package:memory_game/injection_container.dart';

void registerUseCases() {
  /*sl.registerLazySingleton(
    () => VerifyCurrentSesionUseCase(
      splashRepository: sl(),
    ),
  );*/
  sl.registerLazySingleton(
    () => LoginWithEmailAndPasswordUseCase(
      loginRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CreateWithEmailAndPasswordUseCase(
      loginRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetGlobalScoresStreamUseCase(
      globalScoresRepository: sl(),
    ),
  );
}
