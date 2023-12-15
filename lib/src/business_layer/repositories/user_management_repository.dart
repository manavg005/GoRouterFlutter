import 'dart:convert';

import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/api_constants.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/app_network.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/request_response_type.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_management_response.dart';

class UserManagementRepository {
  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> userManagement(String search, int page) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.userManagement,
        requestType: HttpRequestMethods.get,
        queryParameter: {
          "page": "$page",
          "size": "10",
          "search": search,
        },
      );
      LogHelper.logData(
          "DashboardRepository -> user_management ${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: UserManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("DashboardRepository -> user_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> userActiveInactive(String userId) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.userActiveInactive(userId),
        requestType: HttpRequestMethods.patch,
      );
      LogHelper.logData(
          "DashboardRepository -> user_management_active_inactive ${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: UserActiveInactiveResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError(
          "DashboardRepository -> user_management_active_inactive => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
