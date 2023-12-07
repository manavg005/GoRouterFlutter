part of 'cleaner_bloc.dart';

abstract class CleanerManagementEvent {
  const CleanerManagementEvent();
}

class CleanerManagementInitialEvent extends CleanerManagementEvent {}

class CleanerManagementLoadMoreEvent extends CleanerManagementEvent {}

class CleanerManagementLoadPreviousEvent extends CleanerManagementEvent {}

class UserActiveInactiveEvent extends CleanerManagementEvent {
  final String userId;

  UserActiveInactiveEvent(this.userId);
}
