abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? errorType;
  final List<dynamic>? fieldErrors; // RFC 7807 "errors"
  
  const ServerFailure(super.message, {this.statusCode, this.errorType, this.fieldErrors});
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection');
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
