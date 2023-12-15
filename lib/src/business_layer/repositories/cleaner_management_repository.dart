import 'dart:convert';

import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/api_constants.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/app_network.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/request_response_type.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_management_response_model.dart';

class CleanerRepository {
  Map<String, dynamic>? _responseBody;
  Future<BaseApiResponseModel> cleanerActiveInactive(String userId) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.cleanerActiveInactive(userId),
        requestType: HttpRequestMethods.patch,
      );
      LogHelper.logData(
          "DashboardRepository -> cleaner_management_active_inactive ${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: CleanerActiveInactiveResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError(
          "DashboardRepository -> cleaner_management_active_inactive => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> cleanerManagement(
      String search, int page) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.cleanerManagement,
        requestType: HttpRequestMethods.get,
        queryParameter: {
          "search": search,
          "page": "$page",
          "size": "10",
        },
      );
      LogHelper.logData(
          "DashboardRepository -> cleaner_management ${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: CleanerManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("DashboardRepository -> cleaner_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
