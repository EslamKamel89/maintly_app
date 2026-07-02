import 'package:dio/dio.dart';

abstract class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

class OfflineFailure extends Failure {
  const OfflineFailure() : super('Check your internet connection.');
}

class ValidationFailure extends Failure {
  ValidationFailure({required String message, this.errors}) : super(message);

  final Map<String, dynamic>? errors;
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized.']);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = 'You do not have permission to perform this action.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'The requested resource was not found.']);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  static Failure fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout. Please try again.');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Request timeout. Please try again.');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Server took too long to respond.');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Unable to establish a secure connection.');

      case DioExceptionType.connectionError:
        return const OfflineFailure();

      case DioExceptionType.cancel:
        return const ServerFailure('Request cancelled.');

      case DioExceptionType.transformTimeout:
        return const ServerFailure('Response processing timeout.');

      case DioExceptionType.badResponse:
        return _fromResponse(e.response?.statusCode ?? 500, e.response?.data);

      case DioExceptionType.unknown:
        return const ServerFailure('Something went wrong. Please try again.');
    }
  }

  static Failure _fromResponse(int statusCode, dynamic data) {
    final message = data is Map<String, dynamic> ? data['message']?.toString() : null;

    switch (statusCode) {
      case 400:
        return ServerFailure(message ?? 'Bad request.');

      case 401:
        return UnauthorizedFailure(message ?? 'Unauthorized.');

      case 403:
        return ForbiddenFailure(message ?? 'Forbidden.');

      case 404:
        return NotFoundFailure(message ?? 'Resource not found.');

      case 422:
        return ValidationFailure(
          message: message ?? 'Validation failed.',
          errors: data is Map<String, dynamic> ? data['errors'] as Map<String, dynamic>? : null,
        );

      default:
        if (statusCode >= 500) {
          return const ServerFailure('The server encountered an error. Please try again later.');
        }

        return ServerFailure(message ?? 'An unexpected error occurred.');
    }
  }

  factory ServerFailure.unknown() {
    return const ServerFailure('An unexpected error occurred.');
  }
}
