abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? errorType;
  
  const ServerFailure(super.message, {this.statusCode, this.errorType});
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection');
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
