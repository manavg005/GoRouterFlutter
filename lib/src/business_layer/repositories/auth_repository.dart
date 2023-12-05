import 'dart:convert';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/login_request_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/login_response_model.dart';

import '../helpers/log_helper.dart';
import '../network/api_constants.dart';
import '../network/app_network.dart';
import '../network/request_response_type.dart';

class AuthRepository {
  // AuthRepository._internal();
  // static final AuthRepository _instance =
  //     AuthRepository._internal();
  //
  // static AuthRepository get instance => _instance;

  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> login(LoginRequestModel? userData) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.login,
        requestType: HttpRequestMethods.post,
        request: userData,
      );
      LogHelper.logData(
          "LoginSignUpRepository -> login ${response.data.toString()}");
      if (response.data != null) {
        _responseBody = /*jsonDecode(response.data.toString());*/
            jsonDecode(utf8.decode(response.data.toString().runes.toList()));
        LogHelper.logData("_responseBody===> ${_responseBody.toString()}");
        return BaseApiResponseModel(
            data: LoginResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("AuthRepository -> login => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
