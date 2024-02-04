import 'package:memory_game/core/errors/exceptions.dart';

abstract class Failure {}

class LocalFailure implements Failure {
  final String message;
  final ExceptionType type;

  LocalFailure({
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
