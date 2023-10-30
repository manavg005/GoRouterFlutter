enum ExceptionType {
  timeOutException,
  socketException,
  apiException,
  parseException,
  cancelException,
  otherException,
  noException
}

class HttpResponseType {
  static const String success = "success";
  static const String alreadyReserved = "already_reserved";
  static const String failed = "failed";
}

///this class provides Http request types
class HttpRequestMethods {
  static const String post = "POST";
  static const String get = "GET";
  static const String put = "PUT";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

/// class to access timeout utilities
class TimeoutCode {
  static const int connectionTimeout = 25000;
  static const int receiveTimeout = 25000;
  static const int sendTimeout = 25000;
}
