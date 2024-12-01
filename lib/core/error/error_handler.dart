import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';

import 'failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  CONFLICT,
  GONE
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure(error);
    }
  }

  Failure _handleError(DioException error) {
    if (error.type case DioExceptionType.connectionTimeout) {
      return DataSource.CONNECT_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.sendTimeout) {
      return DataSource.SEND_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.receiveTimeout) {
      return DataSource.RECEIVE_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.badResponse) {
      switch (error.response?.statusCode) {
        case ResponseCode.BAD_REQUEST:
          final response = error.response;
          if (response?.data != null) {
            if (response?.data is Map<String, dynamic>) {
              final data = (response?.data as Map<String, dynamic>)['data'];

              if (data != null) {
                if (data is Map<String, dynamic>) {
                  final rejectedAt = data['rejectedAt'];
                  return DataSource.BAD_REQUEST.getFailure(rejectedAt);
                } else if (data is String) {
                  return DataSource.BAD_REQUEST.getFailure(data);
                } else {
                  return DataSource.BAD_REQUEST.getFailure('Unexpected data format');
                }
              } else {
                return DataSource.BAD_REQUEST.getFailure(error.response?.data['message']);
              }
            } else if (response?.data is String) {
              return DataSource.BAD_REQUEST.getFailure(response?.data);
            } else {
              return DataSource.BAD_REQUEST.getFailure('Unexpected response format');
            }
          } else {
            return DataSource.BAD_REQUEST.getFailure(error.response?.data['message']);
          }
        case ResponseCode.FORBIDDEN:
          return DataSource.FORBIDDEN.getFailure(error.response?.data['message']);
        case ResponseCode.UNAUTHORISED:
          return DataSource.UNAUTHORISED.getFailure(error.response?.data['message']);
        case ResponseCode.NOT_FOUND:
          return DataSource.NOT_FOUND.getFailure(error.response?.data['message']);
        case ResponseCode.INTERNAL_SERVER_ERROR:
          return DataSource.INTERNAL_SERVER_ERROR.getFailure(error.response?.data['message']);
        case ResponseCode.CONFLICT:
          return DataSource.CONFLICT.getFailure(error.response?.data['message']);
        case ResponseCode.GONE:
          return DataSource.GONE.getFailure(error.response?.data['message']);
        default:
          return DataSource.DEFAULT.getFailure(error.response?.statusCode);
      }
    } else if (error.type case DioExceptionType.cancel) {
      return DataSource.CANCEL.getFailure(error.response?.data['message']);
    } else if (error.type case DioExceptionType.unknown) {
      return DataSource.DEFAULT.getFailure(error);
    } else {
      return DataSource.DEFAULT.getFailure(error);
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure(error) {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return ServerFailure(error.toString());
      case DataSource.FORBIDDEN:
        return ServerFailure(error.toString());
      case DataSource.UNAUTHORISED:
        return ServerFailure(error.toString());
      case DataSource.NOT_FOUND:
        return ServerFailure(error.toString());
      case DataSource.INTERNAL_SERVER_ERROR:
        return ServerFailure(error.toString());
      case DataSource.CONNECT_TIMEOUT:
        return const ServerFailure(ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return const ServerFailure(ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return const ServerFailure(ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return const ServerFailure(ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return const ServerFailure(ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return const ServerFailure(ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return ServerFailure(error.toString());
      case DataSource.CONFLICT:
        return ServerFailure(error.toString());
      default:
        return ServerFailure(error.toString());
    }
  }
}

class ResponseCode {
  /// API status codes
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int CONFLICT = 409;
  static const int GONE = 410;

  /// local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  /// API response codes
  static const String SUCCESS = AppStrings.success;
  static const String NO_CONTENT = AppStrings.noContent;
  static const String BAD_REQUEST = AppStrings.badRequestError;
  static const String FORBIDDEN = AppStrings.forbiddenError;
  static const String UNAUTHORISED = AppStrings.unauthorizedError;
  static const String NOT_FOUND = AppStrings.notFoundError;
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError;

  /// local responses codes
  static const String DEFAULT = AppStrings.defaultError;
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.defaultError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
