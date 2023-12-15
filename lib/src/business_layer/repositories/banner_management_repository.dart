import 'dart:convert';

import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/api_constants.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/app_network.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/request_response_type.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/add_banner_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/add_banner_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/banner_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/banner_management_response.dart';

class BannerRepository {
  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> bannerManagement(int page, String search) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.bannerManagement,
        requestType: HttpRequestMethods.get,
        queryParameter: {
          "page": "$page",
          "size": "10",
          "search": search,
        },
      );
      LogHelper.logData(
          "BannerRepository  -> banner_management${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: BannerManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("BannerRepository  -> banner_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> bannerActiveInactive(String bannerId) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.bannerActiveInactive(bannerId),
        requestType: HttpRequestMethods.patch,
      );
      LogHelper.logData(
          "BannerRepository  -> banner_management_active_inactive ${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: BannerActiveInactiveResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError(
          "BannerRepository  -> banner_management_active_inactive => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> addBanner(
      UploadBannerImageRequestModel? bannerData) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
          url: ApiConstants.addBanner,
          requestType: HttpRequestMethods.post,
          request: await bannerData?.toFormData(),
          isMultipartEnabled: true);

      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        LogHelper.logData("_responseBody===> ${_responseBody.toString()}");
        return BaseApiResponseModel(
            data: AddBannerResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("BannerRepository -> add banner => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
