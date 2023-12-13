part of 'user_management_bloc.dart';

abstract class UserManagementState {
  const UserManagementState();
}

class UserManagementInitial extends UserManagementState {}

class UserManagementSuccessState extends UserManagementInitial {
  final UserManagementResponseModel userManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  UserManagementSuccessState(
      {required this.userManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
}

class UserActiveInactiveState extends UserManagementInitial {
  final int isActive;
  final String userId;

  UserActiveInactiveState({required this.userId, required this.isActive});
}

class UserManagementLoadingState extends UserManagementInitial {}

class UserManagementErrorState extends UserManagementInitial {
  final String errorMessage;

  UserManagementErrorState({required this.errorMessage});
}
