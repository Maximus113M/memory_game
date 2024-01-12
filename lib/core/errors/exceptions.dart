class SharedException implements Exception {
  final String message;

  SharedException({required this.message});
}

class SplashException implements Exception {
  final String message;

  SplashException({required this.message});
}

class LoginException implements Exception {
  final String message;

  LoginException({required this.message});
}

class RegisterException implements Exception {
  final String message;

  RegisterException({required this.message});
}

class HomeException implements Exception {
  final String message;

  HomeException({required this.message});
}

class LocalScoresException implements Exception {
  final String message;

  LocalScoresException({required this.message});
}

class GlobalScoresException implements Exception {
  final String message;

  GlobalScoresException({required this.message});
}
