import 'dart:convert';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/api_constants.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/app_network.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/network/request_response_type.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/send_notification_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_management_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/home_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/notification_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/payment_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/send_notification_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_management_response.dart';

class DashboardRepository {
  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> homeManagement() async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.homeManagement,
        requestType: HttpRequestMethods.get,
      );
      LogHelper.logData(
          "DashboardRepository -> home_management${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: HomeManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("DashboardRepository -> home_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

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

  Future<BaseApiResponseModel> cleanerManagement(int page) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.cleanerManagement,
        requestType: HttpRequestMethods.get,
        queryParameter: {
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

  //
  // Future<BaseApiResponseModel> cleanerActiveInactive(String userId) async {
  //   try {
  //     BaseApiResponseModel response = await AppNetwork().request(
  //       url: ApiConstants.cleanerActiveInactive(userId),
  //       requestType: HttpRequestMethods.patch,
  //     );
  //     LogHelper.logData("DashboardRepository -> cleaner_management_active_inactive ${response.data}");
  //     if (response.data != null) {
  //       _responseBody =
  //           jsonDecode(response.data.toString());
  //       return BaseApiResponseModel(
  //           data: UserActiveInactiveResponseModel.fromJson(_responseBody!));
  //
  //     } else {
  //       return BaseApiResponseModel(exceptionType: response.exceptionType);
  //     }
  //   } catch (e) {
  //     LogHelper.logError("DashboardRepository -> cleaner_management_active_inactive => $e");
  //     return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
  //   }
  // }
  //
  // Future<BaseApiResponseModel> bookingManagement() async {
  //   try {
  //     BaseApiResponseModel response = await AppNetwork().request(
  //       url: ApiConstants.bookingManagement,
  //       requestType: HttpRequestMethods.get,
  //     );
  //     LogHelper.logData("DashboardRepository -> booking_management${response.data}");
  //     if (response.data != null) {
  //       _responseBody =
  //           jsonDecode(response.data.toString());
  //       return BaseApiResponseModel(
  //           data: BookingManagementResponseModel.fromJson(_responseBody!));
  //
  //     } else {
  //       return BaseApiResponseModel(exceptionType: response.exceptionType);
  //     }
  //   } catch (e) {
  //     LogHelper.logError("DashboardRepository -> booking_management => $e");
  //     return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
  //   }
  // }
  //
  Future<BaseApiResponseModel> notificationManagement(int page) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.notificationManagement,
        requestType: HttpRequestMethods.get,
        queryParameter: {
          "page": "$page",
          "size": "10",
        },
      );
      LogHelper.logData(
          "DashboardRepository -> notification_management${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: NotificationManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError(
          "DashboardRepository -> notification_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> sendNotification(
      SendNotificationRequestModel? notiData) async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.sendNotification,
        requestType: HttpRequestMethods.post,
        request: notiData,
      );
      LogHelper.logData(
          "LoginSignUpRepository -> login ${response.data.toString()}");
      if (response.data != null) {
        _responseBody = /*jsonDecode(response.data.toString());*/
            jsonDecode(utf8.decode(response.data.toString().runes.toList()));
        LogHelper.logData("_responseBody===> ${_responseBody.toString()}");
        return BaseApiResponseModel(
            data: SendNotificationResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("AuthRepository -> login => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> paymentManagement() async {
    try {
      BaseApiResponseModel response = await AppNetwork().request(
        url: ApiConstants.paymentManagement,
        requestType: HttpRequestMethods.get,
      );
      LogHelper.logData(
          "DashboardRepository -> payment_management${response.data}");
      if (response.data != null) {
        _responseBody = jsonDecode(response.data.toString());
        return BaseApiResponseModel(
            data: PaymentManagementResponseModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: response.exceptionType);
      }
    } catch (e) {
      LogHelper.logError("DashboardRepository -> payment_management => $e");
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
