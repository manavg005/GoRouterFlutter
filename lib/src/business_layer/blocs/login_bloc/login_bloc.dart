import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/auth_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_alerts.dart';

import '../../../data_layer/models/base/base_api_response_model.dart';
import '../../../data_layer/models/request/login_request_model.dart';
import '../../../data_layer/models/response/login_response_model.dart';
import '../../network/request_response_type.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _registrationRepository = AuthRepository();

  LoginResponseModel _loginResponseModel = LoginResponseModel();

  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LoginToHomeNavigateEvent>(loginToHomeNavigateEvent);
    on<LoginToForgotPasswordNavigateEvent>(loginToForgotPasswordNavigateEvent);
  }

  Future<FutureOr<void>> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    // emit(LoginLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    // try {
    //   emit(LoginSuccessState());
    // } catch (e) {
    //   emit(LoginErrorState());
    // }
  }

  FutureOr<void> loginToHomeNavigateEvent(
      LoginToHomeNavigateEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToHomeActionState());
  }

  FutureOr<void> loginToForgotPasswordNavigateEvent(
      LoginToForgotPasswordNavigateEvent event, Emitter<LoginState> emit) {}

  Future<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    print("dhsfjhvsdb");
    emit(LoginLoadingState());
    final BaseApiResponseModel response =
        await _registrationRepository.login(event.loginRequestModel);
    if (response.data != null && response.data is LoginResponseModel) {
      _loginResponseModel = response.data;
      LogHelper.logData("response inside provider===> ${response.data}");
      LogHelper.logData(
          "_loginResponseModel inside provider===> ${_loginResponseModel.data!.toJson().toString()}");

      await UserStateHiveHelper.instance
          .setAccessToken(_loginResponseModel.data!.userdata!.token ?? "");
      await UserStateHiveHelper.instance.setUserName(
          "${_loginResponseModel.data?.userdata!.userDetails!.firstName} ${_loginResponseModel.data?.userdata!.userDetails!.lastName}" ??
              "");
      await UserStateHiveHelper.instance.setUserEmail(
          _loginResponseModel.data?.userdata?.userDetails?.email ?? "");
      await UserStateHiveHelper.instance.setUserPhoneNo(
          _loginResponseModel.data?.userdata?.userDetails?.phoneNumber ?? "");

      emit(LoginNavigateToHomeActionState());
      AlertHelper.showToast(_loginResponseModel.msg ?? "");
      emit(LoginSuccessState(loginResponse: _loginResponseModel));

      log("inside login");
    } else {
      LogHelper.logError("outside the response");
      emit(LoginErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
    // } else {
    //   return "No internet";
    // }
  }
}

// Future<void> login({required String mobileNumber}) async {
//   if (mobileNumber.isNotEmpty) {
//     emit(LoginLoadingState());
//     LoginRequestModel request = LoginRequestModel();
//     final response = await LoginSignupRepository().login(request);
//     if (response.data != null && response.data is LoginResponseModel) {
//       LoginResponseModel loginObj = response.data;
//       if (loginObj.statusCode == 200) {
//         emit(LoginSuccessState(
//           captchaCode: loginObj.userLoginAPI!.response!.first.captchaCode,
//           successMessage: loginObj.userLoginAPI?.result,
//         ));
//       } else {
//         emit(LoginErrorState(
//             errorMessage:
//                 UtilHelper.instance.getError(loginObj.userLoginAPI?.result)));
//       }
//     } else {
//       emit(LoginErrorState(
//           errorMessage: UtilHelper.instance
//               .getExceptionMessage(exceptionType: response.exceptionType)));
//     }
//   } else {
//     emit(LoginErrorState(
//         errorMessage: AppLocalizations.current.mobileNumberRequired));
//   }
// }

/*Future<void> login(LoginRequestModel? modelEmail) async {
  final BaseApiResponseModel response =
      await LoginSignupRepository.instance.login(modelEmail);
  if (response.data != null && response.data is LoginResponseModel) {
    _loginResponseModel = response.data;
    LogHelper.logData("response inside provider===> ${response.data}");
    LogHelper.logData(
        "_loginResponseModel inside provider===> ${_loginResponseModel.data!.toJson().toString()}");
    LogHelper.logData(
        "_loginResponseModel inside provider===> ${_loginResponseModel.data!.userdata}");
    LogHelper.logData(
        "_loginResponseModel token inside provider===> ${_loginResponseModel.data!.userdata!.token}");
    // await UserStateHiveHelper.instance.clearData();
    // await UserStateHiveHelper.instance.setUserDetails(_loginResponseModel.data?.userdata!.userDetails!.firstName ?? "nothin");
    // await UserStateHiveHelper.instance.setAccessToken(_loginResponseModel.data!.userdata!.token ?? "");
    return HttpResponseType.success;
  } else {
    LogHelper.logError("outside the response");
    return getExceptionMessage(exceptionType: response.exceptionType);
    ;
  }
}*/
