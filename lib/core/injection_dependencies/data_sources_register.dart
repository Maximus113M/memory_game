import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/login/data/datasources/login_datasource.dart';

void registerDataSources() {
  /*sl.registerLazySingleton<SharedDataSource>(
    () => SharedDataSourceImpl(),
  );
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      db: sl(),
    ),
  );*/
  sl.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(
      firebaseAuth: sl(),
    ),
  );
}
