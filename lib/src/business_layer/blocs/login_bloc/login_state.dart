part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponseModel loginResponse;

  LoginSuccessState({required this.loginResponse});
}

class LoginFailureState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginNavigateToHomeActionState extends LoginActionState {}

class LoginNavigateToForgetPasswordActionState extends LoginActionState {}
