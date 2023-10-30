import '../../business_layer/network/request_response_type.dart';

class BaseApiResponseModel {
  BaseApiResponseModel({
    this.exceptionType = ExceptionType.noException,
    this.data,
  });

  ExceptionType exceptionType;
  dynamic data;
}

class ApiResponseModel<T> {
  ApiResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.exceptionType = ExceptionType.noException,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    return ApiResponseModel<T>(
      success: json['status'],
      statusCode: json['statusCode'],
      message: json['msg'],
      data: create(json['data']),
    );
  }

  bool? success;
  int? statusCode;
  String? message;
  T? data;
  ExceptionType exceptionType;
}

class EmptyDataResponseModel {
  EmptyDataResponseModel();

  EmptyDataResponseModel.fromJson(Map<String, dynamic> json);
}
