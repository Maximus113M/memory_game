import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/global_config/domain/use_cases/use_cases.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_local_register_use_case.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/clear_local_scores_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:memory_game/features/splash/domain/use_cases/is_user_sign_in_use_case.dart';
import 'package:memory_game/features/game/domain/use_cases.dart/score_db_register_use_case.dart';
import 'package:memory_game/features/local_scores/domain/use_cases/get_local_scores_use_case.dart';
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
    () => SendPasswordResetEmailUseCase(
      signInRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ScoreDbRegisterUseCase(
      gameRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ScoreLocalRegisterUseCase(
      gameRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetGlobalScoresUseCase(
      globalScoresRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetLocalScoresUseCase(
      localScoresRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ClearLocalScoresUseCase(
      localScoresRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateUserNameUseCase(
      globalConfigRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateEmailUseCase(
      globalConfigRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdatePasswordUseCase(
      globalConfigRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteAccountUseCase(
      globalConfigRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ValidateCredentialsUseCase(
      globalConfigRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateUserSettingsUseCase(
      globalConfigRepository: sl(),
    ),
  );
}
