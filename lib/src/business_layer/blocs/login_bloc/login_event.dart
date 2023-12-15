part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonClickedEvent extends LoginEvent {
  final LoginRequestModel loginRequestModel;

  LoginButtonClickedEvent({required this.loginRequestModel});
}

class LogoutButtonClickedEvent extends LoginEvent {}

class ChangePasswordClickedEvent extends LoginEvent {
  final ChangePasswordRequestModel changePasswordRequestModel;

  ChangePasswordClickedEvent({required this.changePasswordRequestModel});
}
