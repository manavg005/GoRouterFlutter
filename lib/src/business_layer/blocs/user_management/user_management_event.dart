part of 'user_management_bloc.dart';

abstract class UserManagementEvent {
  const UserManagementEvent();
}

class UserManagementInitialEvent extends UserManagementEvent {}

// class NextPageEvent extends UserManagementEvent {
//   final int page;
//
//   NextPageEvent({required this.page});
// }

class UserManagementLoadMoreEvent extends UserManagementEvent {}

class UserManagementLoadPreviousEvent extends UserManagementEvent {}

class UserActiveInactiveEvent extends UserManagementEvent {
  final String userId;

  UserActiveInactiveEvent(this.userId);
}
