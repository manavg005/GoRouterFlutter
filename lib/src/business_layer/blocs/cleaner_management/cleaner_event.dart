part of 'cleaner_bloc.dart';

abstract class CleanerManagementEvent {
  const CleanerManagementEvent();
}

class CleanerManagementInitialEvent extends CleanerManagementEvent {}

class CleanerManagementLoadMoreEvent extends CleanerManagementEvent {}

class CleanerManagementLoadPreviousEvent extends CleanerManagementEvent {}

class CleanerActiveInactiveEvent extends CleanerManagementEvent {
  final String userId;

  CleanerActiveInactiveEvent({required this.userId});
}

class CleanerManagementSearchEvent extends CleanerManagementEvent {
  final String searchQuery;
  final int page;

  CleanerManagementSearchEvent(this.searchQuery, this.page);
}
