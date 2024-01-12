import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/login/domain/repositories/login_repository.dart';
import 'package:memory_game/features/login/data/repositories/login_repository_impl.dart';
import 'package:memory_game/features/global_scores/domain/repositories/global_scores_repository.dart';
import 'package:memory_game/features/global_scores/data/repositories/global_scores_repository_impl.dart';

void registerRepositories() {
  /*sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeDataSource: sl(),
    ),
  );*/
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<GlobalScoresRepository>(
    () => GlobalScoresRepositoryImpl(
      globalScoresDataSource: sl(),
    ),
  );
}
