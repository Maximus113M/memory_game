import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._();

  SharedPreferencesService._();

  factory SharedPreferencesService() {
    return _instance;
  }

  static final Future<SharedPreferences> sharedPrefs =
      SharedPreferences.getInstance();
}
