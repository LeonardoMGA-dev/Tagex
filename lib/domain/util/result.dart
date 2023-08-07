abstract class Result<T> {
  factory Result.success(T content) {
    return SuccessResult(content);
  }

  factory Result.error(ErrorEntity error) {
    return ErrorResult(error);
  }
}

class SuccessResult<T> implements Result<T> {
  final T content;

  SuccessResult(this.content);
}

class ErrorResult<T> implements Result<T> {
  final ErrorEntity error;

  ErrorResult(this.error);
}

abstract class ErrorEntity {}

class NetworkError implements ErrorEntity {
  final int? httpStatusCode;

  NetworkError(this.httpStatusCode);
}

class NoCredentialsError implements ErrorEntity {}

class InvalidArgumentError implements ErrorEntity {
  final String argument;

  InvalidArgumentError(this.argument);
}

class UnknownError implements ErrorEntity {
  final Exception e;

  UnknownError(this.e);
}

class UnauthorizedError implements ErrorEntity {}

class Empty {}
