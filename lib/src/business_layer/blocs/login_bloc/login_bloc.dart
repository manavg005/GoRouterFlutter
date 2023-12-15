import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/dialog_util.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/log_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/auth_repository.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/login_info.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';

import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/common_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/change_password_request_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/login_request_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _registrationRepository = AuthRepository();
  CommonResponse _logoutResponse = CommonResponse();
  CommonResponse _changePasswordResponse = CommonResponse();

  LoginResponseModel _loginResponseModel = LoginResponseModel();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LogoutButtonClickedEvent>(logoutButtonClickedEvent);
    on<ChangePasswordClickedEvent>(changePasswordClickedEvent);
  }

  Future<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final BaseApiResponseModel response =
        await _registrationRepository.login(event.loginRequestModel);
    if (response.data != null && response.data is LoginResponseModel) {
      _loginResponseModel = response.data;

      if (_loginResponseModel.status!) {
        await UserStateHiveHelper.instance
            .setAccessToken(_loginResponseModel.data!.userdata!.token ?? "");
        await UserStateHiveHelper.instance.setUserName(
            "${_loginResponseModel.data?.userdata!.userDetails!.firstName} ${_loginResponseModel.data?.userdata!.userDetails!.lastName}");
        await UserStateHiveHelper.instance.setUserEmail(
            _loginResponseModel.data?.userdata?.userDetails?.email ?? "");
        await UserStateHiveHelper.instance.setUserPhoneNo(
            _loginResponseModel.data?.userdata?.userDetails?.phoneNumber ?? "");
        LoginInfo.instance.isLoggedIn = true;

        emit(LoginNavigateToHomeActionState());
        DialogUtil.showToast(_loginResponseModel.msg ?? "");
        emit(LoginSuccessState(loginResponse: _loginResponseModel));
      } else {
        DialogUtil.showToast(_loginResponseModel.msg! ?? "");
      }

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

  /// logout
  FutureOr<void> logoutButtonClickedEvent(
      LogoutButtonClickedEvent event, Emitter<LoginState> emit) async {
    final BaseApiResponseModel response =
        await _registrationRepository.logout();
    if (response.data != null && response.data is CommonResponse) {
      _logoutResponse = response.data;
      if (_logoutResponse.status!) {
        await UserStateHiveHelper.instance.clearData();
        LoginInfo.instance.isLoggedIn = false;
        emit(LogoutActionState());
        DialogUtil.showToast(_logoutResponse.msg ?? "");
      } else {
        DialogUtil.showToast(_logoutResponse.msg ?? "");
      }
    } else {
      emit(LoginErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
  }

  FutureOr<void> changePasswordClickedEvent(
      ChangePasswordClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final BaseApiResponseModel response = await _registrationRepository
        .changePassword(event.changePasswordRequestModel);
    if (response.data != null && response.data is CommonResponse) {
      _changePasswordResponse = response.data;
      if (_changePasswordResponse.status!) {
        emit(ChangePasswordActionState());
        DialogUtil.showToast(_changePasswordResponse.msg ?? "");
      } else {
        DialogUtil.showToast(_changePasswordResponse.msg! ?? "");
      }
    } else {
      emit(LoginErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
  }
}
