import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:memory_game/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';
import 'package:memory_game/features/global_scores/data/repositories/global_scores_repository_impl.dart';

void registerRepositories() {
  /*sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeDataSource: sl(),
    ),
  );*/
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(
      signInDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<GlobalScoresRepository>(
    () => GlobalScoresRepositoryImpl(
      globalScoresDataSource: sl(),
    ),
  );
}
