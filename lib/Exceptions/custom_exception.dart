// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomException implements Exception {
  final dynamic prefix;
  final dynamic message;

  CustomException([this.prefix, this.message]);

  @override
  String toString() => 'CustomException(prefix: $prefix, message: $message)';
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super("Error During Communication : ", message);
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super("Invalid Request : ", message);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super("Unauthorised : ", message);
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super("Invalid Input : ", message);
}
