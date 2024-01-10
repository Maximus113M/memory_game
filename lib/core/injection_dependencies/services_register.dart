import 'package:memory_game/injection_container.dart';
import 'package:memory_game/core/services/auth_service.dart';

void registerServices() {
  sl.registerLazySingleton<AuthService>(
    () => AuthService(
      firebaseAuth: sl(),
    ),
  );
}
