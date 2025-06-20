import 'package:foode/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
    : assert(
        statusCode is String || statusCode is int,
        'statusCode can only be a ${statusCode.runtimeType}',
      );

  final String message;
  final dynamic statusCode;

  String get errorMessage =>
      '$statusCode ${statusCode is String ? statusCode : ''} Error: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}
