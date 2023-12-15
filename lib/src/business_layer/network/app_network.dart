// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/request_response_type.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/dialog_util.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/flavor_configuration_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'http_response_code.dart';

/// [AppNetwork] class is responsible for all network calls
class AppNetwork {
  static AppNetwork? _instance;

  static final String _baseUrl = FlavorConfig.instance.values.baseUrl;
  static final String _apiKey = FlavorConfig.instance.values.apiKey;

  Dio? _dioClient;

  /// Internal method to create instance of [AppNetwork] class
  AppNetwork._create() {
    _dioClient = Dio();
    // (_dioClient!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    _dioClient!.options.baseUrl = _baseUrl;
    _dioClient!.options.responseType = ResponseType.json;
    _dioClient!.options.sendTimeout = const Duration(seconds: 30);
    _dioClient!.options.connectTimeout = const Duration(seconds: 30);
    _dioClient!.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// Factory constructor to get instance of [AppNetwork]
  factory AppNetwork() {
    return _instance ??= AppNetwork._create();
  }

  final String _debug = "[Debug]";
  final String _postData = " Post Data";
  final String _paramData = " Param Data";

  final String _keyAuth = 'Authorization';
  final String _keyApi = 'x-api-key';
  final String _timezone = 'timezone';

  /// Entry point method for all network request calls,this method gets data
  /// from network and send it back to caller
  Future<BaseApiResponseModel> request({
    required String url,
    dynamic request,
    File? image,
    Map<String, dynamic>? queryParameter,
    final String? requestType,
    bool? headerIncluded = true,
    String? token,
    Function? fileUploadProgress,
    bool isMultipartEnabled = false,
    bool isCheckUnauthorizedAccess = true,
  }) async {
    try {
      LogHelper.logData(_dioClient!.options.baseUrl + url);
      if (request != null && !isMultipartEnabled) {
        LogHelper.logData("$_debug$_postData ${jsonEncode(request)}");
      }
      if (queryParameter != null) {
        LogHelper.logData("$_debug$_paramData $queryParameter");
      }
      //var options = Options(method: requestType);
      _dioClient!.options.method = requestType!;
      String? accessToken =
          "Bearer ${await UserStateHiveHelper.instance.getAccessToken()}";
      if ((headerIncluded != null && headerIncluded) || token != null) {
        LogHelper.logData("$_keyAuth => $accessToken");
        _dioClient!.options.headers = {
          _keyApi: _apiKey,
          _keyAuth: token ?? accessToken,
          _timezone: "Asia/Calcutta"
        };
      } else {
        _dioClient!.options.headers = {
          _keyApi: _apiKey,
        };
      }
      if (isMultipartEnabled) {
        _dioClient!.options.contentType = "multipart/form-data";
      } else {
        _dioClient!.options.contentType = "application/json";
      }
      LogHelper.logData('Request URL: $url');
      Response serverResponse = await _dioClient!.request(
        url,
        data: await request,
        queryParameters: queryParameter ?? {},
        //options: options,
        onSendProgress: (int sent, int total) {
          LogHelper.logData("${sent / total * 100} total sent");
          LogHelper.logData("$total total");
          LogHelper.logData("$sent sent");
          if (fileUploadProgress != null) {
            fileUploadProgress(sent / total * 100);
          }
        },
        onReceiveProgress: (int received, int total) {
          LogHelper.logData("${received / total * 100} total received");
          LogHelper.logData("$total total");
          LogHelper.logData("$received received");
        },
      );
      switch (serverResponse.statusCode) {
        case HttpResponseCode.internalServerError:
          return BaseApiResponseModel(
              exceptionType: ExceptionType.apiException);
        // case HttpResponseCode.forbidden:
        case HttpResponseCode.unAuthorized:
          navigatorKey.currentContext!.go('/login');
          return BaseApiResponseModel(
              exceptionType: ExceptionType.apiException);
        default:
          return BaseApiResponseModel(
            data: serverResponse,
            exceptionType: ExceptionType.noException,
          );
      }
    } catch (e) {
      return _requestCatchBloc(e, isCheckUnauthorizedAccess, url);
    }
  }

  /// Method used to handle caught errors
  BaseApiResponseModel _requestCatchBloc(
      Object error, bool isCheckUnauthorizedAccess, String path) {
    if (error is TimeoutException) {
      LogHelper.logError('Timeout Exception ====> $path, ${error.toString()}');
      return BaseApiResponseModel(
          exceptionType: ExceptionType.timeOutException);
    } else if (error is SocketException) {
      LogHelper.logError('Socket Exception ====> $path, ${error.toString()}');
      return BaseApiResponseModel(exceptionType: ExceptionType.socketException);
    } else if (error is DioError) {
      return _handleDioError(error, isCheckUnauthorizedAccess);
    } else {
      LogHelper.logError('Other Exception ====> $path, ${error.toString()}');
      return BaseApiResponseModel(exceptionType: ExceptionType.otherException);
    }
  }

  /// Method used to checks for all the dio errors
  BaseApiResponseModel _handleDioError(
      final DioError error, bool isCheckUnauthorizedAccess) {
    switch (error.type) {
      case DioErrorType.cancel:
        LogHelper.logError("Request cancelled ====>${error.message}");
        return BaseApiResponseModel(
            exceptionType: ExceptionType.cancelException);
      case DioErrorType.connectionTimeout:
        LogHelper.logError(
            "Connection timeout ====> ${error.requestOptions.path}, ${error.message}}");
        return BaseApiResponseModel(
            exceptionType: ExceptionType.timeOutException);
      // case DioErrorType.other:
      //   LogHelper.logError("Other Error ====> ${error.requestOptions.path}, ${error.message}");
      //   return BaseApiResponseModel(exceptionType: ExceptionType.socketException);
      case DioErrorType.receiveTimeout:
        LogHelper.logError(
            "Receive Timeout Error ====> ${error.requestOptions.path}, ${error.message}");
        return BaseApiResponseModel(
            exceptionType: ExceptionType.timeOutException);
      case DioErrorType.sendTimeout:
        LogHelper.logError(
            "Send Timeout Error ====> ${error.requestOptions.path}, ${error.message}");
        return BaseApiResponseModel(
            exceptionType: ExceptionType.timeOutException);
      case DioErrorType.badResponse:
        LogHelper.logError(
            "Api Error Response Message ====> ${error.requestOptions.path}, ${error.message}, ${error.response}");
        UserStateHiveHelper.instance.setIsUserLoggedIn(false);
        if (error.response?.statusCode == HttpResponseCode.unAuthorized) {
          _sessionExpired(error.response!.data['msg']);
          return BaseApiResponseModel(
              exceptionType: ExceptionType.otherException,
              data: error.response);
        } else if (error.response?.statusCode == HttpResponseCode.forbidden) {
          return BaseApiResponseModel(
              exceptionType: ExceptionType.cancelException,
              data: error.response);
        } else if (error.response?.statusCode == HttpResponseCode.badRequest) {
          return BaseApiResponseModel(
              exceptionType: ExceptionType.apiException, data: error.response);
        } else {
          return BaseApiResponseModel(
              exceptionType: ExceptionType.otherException,
              data: error.response);
        }
      default:
        LogHelper.logError(
            "Api Other Error ====> ${error.requestOptions.path}, ${error.message}");
        return BaseApiResponseModel(
            exceptionType: ExceptionType.otherException);
    }
  }

  /// Method used to handle session expired
  void _sessionExpired(dynamic response) {
    try {
      navigatorKey.currentContext!.go('/login');

      print("######Session expired#####");

      /// handle session expired
      DialogUtil.showAlertDialog(
          navigatorKey.currentContext!, "Session Expired", "$response", () {
        //log out
        _logOut();
      });
    } catch (e) {
      navigatorKey.currentContext!.go('/login');
      LogHelper.logError(e.toString());
    }
  }

  _logOut() {
    print("in app network");

/*    UserStateHiveHelper.instance.clearData();
    UserStateHiveHelper.instance.setIsOnboardingCompleted(true);
    SocialLoginHelper.instance.signOut();
    Provider.of<BottomNavProvider>(navigatorKey.currentContext!, listen: false)
        .setScreen(0, notify: false);
    Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
        ScreenNavigation.createRoute(const LoginScreen()), (route) => false);*/
  }
}
