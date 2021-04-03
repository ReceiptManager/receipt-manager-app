class ConnectionExceptions implements Exception {}

class TimeoutException extends ConnectionExceptions {
  TimeoutException() : super();
}

class NetworkException extends ConnectionExceptions {
  NetworkException() : super();
}

class BadRequestException extends ConnectionExceptions {
  BadRequestException() : super();
}

class UnauthorisedException extends ConnectionExceptions {
  UnauthorisedException() : super();
}

class ServerException extends ConnectionExceptions {
  ServerException() : super();
}

class AppExceptions implements Exception {}

class GenericException extends AppExceptions {
  GenericException() : super();
}