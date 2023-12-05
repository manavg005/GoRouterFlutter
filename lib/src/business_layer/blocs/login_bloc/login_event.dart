part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginInitialEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final LoginRequestModel loginRequestModel;

  LoginButtonClickedEvent({required this.loginRequestModel});
}

class LoginToHomeNavigateEvent extends LoginEvent {}

class LoginToForgotPasswordNavigateEvent extends LoginEvent {}
