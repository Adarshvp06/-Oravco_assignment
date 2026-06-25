

import 'package:dio/dio.dart';

enum ExceptionType {
  network,
  timeout,
  unauthorized,
  notFound,
  validation,
  server,
  cancel,
  rateLimit,
  unknown,
}

class CustomException implements Exception {
  final String message;
  final int? statusCode;
  final ExceptionType type;

  const CustomException({
    required this.message,
    required this.type,
    this.statusCode,
  });

  static CustomException fromError(
    Object error, {
    String fallbackMessage = 'Something went wrong. Please try again.',
  }) {
    if (error is CustomException) return error;

    if (error is DioException) {
      return _handleDioError(error, fallbackMessage);
    }

    return CustomException(
      message: fallbackMessage,
      type: ExceptionType.unknown,
    );
  }

  static CustomException _handleDioError(
    DioException error,
    String fallbackMessage,
  ) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return CustomException(
          message: 'Request timed out. Please try again.',
          type: ExceptionType.timeout,
        );

      case DioExceptionType.connectionError:
        return CustomException(
          message: 'No internet connection. Please check your network.',
          type: ExceptionType.network,
        );

      case DioExceptionType.cancel:
        return CustomException(
          message: 'Request was cancelled.',
          type: ExceptionType.cancel,
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      default:
        return CustomException(
          message: fallbackMessage,
          type: ExceptionType.unknown,
        );
    }
  }

  static CustomException _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return CustomException(
          message: 'Bad request. Please try again.',
          type: ExceptionType.validation,
          statusCode: statusCode,
        );
      case 401:
        return CustomException(
          message: 'Session expired. Please login again.',
          type: ExceptionType.unauthorized,
          statusCode: statusCode,
        );
      case 403:
        return CustomException(
          message: 'Access denied.',
          type: ExceptionType.unauthorized,
          statusCode: statusCode,
        );
      case 404:
        return CustomException(
          message: 'Data not found.',
          type: ExceptionType.notFound,
          statusCode: statusCode,
        );
      case 422:
        return CustomException(
          message: 'Invalid input. Please check again.',
          type: ExceptionType.validation,
          statusCode: statusCode,
        );
      case 429:
        return CustomException(
          message: 'Too many requests. Please try again later.',
          type: ExceptionType.rateLimit,
          statusCode: statusCode,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return CustomException(
          message: 'Server error. Please try later.',
          type: ExceptionType.server,
          statusCode: statusCode,
        );
      default:
        return CustomException(
          message: 'Something went wrong.',
          type: ExceptionType.unknown,
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => message;
}