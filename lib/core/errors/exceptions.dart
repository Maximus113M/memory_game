class SharedPreferenceException implements Exception {
  final String message;
  final ExceptionType type;

  SharedPreferenceException({
    required this.message,
    required this.type,
  });
}

class ServerException implements Exception {
  final String message;
  final ExceptionType type;

  ServerException({
    required this.message,
    required this.type,
  });
}

enum ExceptionType {
  sharedException,
  splashException,
  singInException,
  homeException,
  gameException,
  globalScoresException,
}
