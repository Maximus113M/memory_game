import 'package:memory_game/injection_container.dart';
import 'package:memory_game/features/login/domain/repositories/login_repository.dart';
import 'package:memory_game/features/login/data/repositories/login_repository_impl.dart';

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
}
