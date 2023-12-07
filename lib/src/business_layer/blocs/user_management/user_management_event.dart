part of 'user_management_bloc.dart';

abstract class UserManagementEvent {
  const UserManagementEvent();
}

class UserManagementInitialEvent extends UserManagementEvent {}

class UserManagementLoadMoreEvent extends UserManagementEvent {}

class UserManagementLoadPreviousEvent extends UserManagementEvent {}

class UserActiveInactiveEvent extends UserManagementEvent {
  final String userId;

  UserActiveInactiveEvent(this.userId);
}

class UserManagementSearchEvent extends UserManagementEvent {
  final String searchQuery;
  final int page;

  UserManagementSearchEvent(this.searchQuery, this.page);
}
