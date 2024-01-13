import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:memory_game/features/global_scores/data/datasources/global_scores_data_source.dart';

void registerDataSources() {
  /*sl.registerLazySingleton<SharedDataSource>(
    () => SharedDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      db: sl(),
    ),
  );*/
  sl.registerLazySingleton<SignInDataSource>(
    () => SignInDataSourceImpl(
      firebaseAuth: sl(),
      db: sl(),
    ),
  );
  sl.registerLazySingleton<GlobalScoresDataSource>(
    () => GlobalScoresDataSourceImpl(
      db: sl(),
    ),
  );
}
