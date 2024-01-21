import 'package:memory_game/features/game/data/datasources/game_data_source.dart';
import 'package:memory_game/features/global_config/data/datasources/global_config_data_source.dart';
import 'package:memory_game/features/local_scores/data/datasources/local_scores_data_source.dart';
import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/splash/data/datasources/splash_data_source.dart';
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
  sl.registerLazySingleton<SplashDataSource>(
    () => SplashDataSourceImpl(
      firebaseAuth: sl(),
      db: sl(),
    ),
  );
  sl.registerLazySingleton<SignInDataSource>(
    () => SignInDataSourceImpl(
      firebaseAuth: sl(),
      db: sl(),
    ),
  );
  sl.registerLazySingleton<GameDataSource>(
    () => GameDataSourceImpl(
      db: sl(),
    ),
  );
  sl.registerLazySingleton<GlobalScoresDataSource>(
    () => GlobalScoresDataSourceImpl(
      db: sl(),
    ),
  );
  sl.registerLazySingleton<LocalScoresDataSource>(
    () => LocalScoresDataSourceImpl(),
  );
  sl.registerLazySingleton<GlobalConfigDatasource>(
    () => GlobalConfigDatasourceImpl(
      db: sl(),
    ),
  );
}
