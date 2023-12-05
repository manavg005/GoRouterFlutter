part of 'dashboard_bloc.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class DashboardSuccessState extends DashboardInitial {
  final HomeManagementResponseModel homeManagementResponseModel;

  DashboardSuccessState({required this.homeManagementResponseModel});
}

class DashboardLoadingState extends DashboardInitial {}

class DashboardErrorState extends DashboardInitial {
  final String errorMessage;

  DashboardErrorState({required this.errorMessage});
}
