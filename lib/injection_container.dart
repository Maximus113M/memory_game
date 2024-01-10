import 'package:memory_game/core/injection_dependencies/injection_records.dart';

import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

init() async {
  registerFirebaseAuth();
  registerFirestore();
  registerServices();
  registerDataSources();
  registerRepositories();
  registerUseCases();
  registerProviders();
}
