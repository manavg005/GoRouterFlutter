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

  // Add copyWith method for convenient state modification
  UserManagementSuccessState copyWith({
    UserManagementResponseModel? userManagementResponseModel,
    bool? hasMoreData,
    int? currentPage,
  }) {
    return UserManagementSuccessState(
      userManagementResponseModel:
          userManagementResponseModel ?? this.userManagementResponseModel,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class UserActiveInactiveState extends UserManagementInitial {}

class UserManagementLoadingState extends UserManagementInitial {}

class UserManagementErrorState extends UserManagementInitial {
  final String errorMessage;

  UserManagementErrorState({required this.errorMessage});
}
