import 'package:memory_game/core/errors/exceptions.dart';

abstract class Failure {}

class SharedPreferencesFailure implements Failure {
  final String message;
  final ExceptionType type;

  SharedPreferencesFailure({
    required this.message,
    required this.type,
  });
}

class ServerFailure implements Failure {
  final String message;
  final ExceptionType type;

  ServerFailure({
    required this.message,
    required this.type,
  });
}
