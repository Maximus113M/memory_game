import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/splash/domain/use_cases/is_user_sign_in_use_case.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/game_db_register_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/verify_current_session_use_case.dart';
import 'package:memory_game/features/global_scores/domain/use_cases/get_global_scores_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/create_with_email_and_password_use_case.dart';

void registerUseCases() {
  sl.registerLazySingleton(
    () => IsUserSignInUseCase(
      splashRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => VerifyCurrentSessionUseCase(
      signInRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoginWithEmailAndPasswordUseCase(
      signInRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CreateWithEmailAndPasswordUseCase(
      signInRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GameDbRegisterUseCase(
      gameRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetGlobalScoresUseCase(
      globalScoresRepository: sl(),
    ),
  );
}
