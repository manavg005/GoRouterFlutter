part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSuccessState extends NotificationInitial {
  final NotificationManagementResponseModel notificationManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  NotificationSuccessState(
      {required this.notificationManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
}

class NotificationLoadingState extends NotificationInitial {}

class NotificationErrorState extends NotificationInitial {
  final String errorMessage;

  NotificationErrorState({required this.errorMessage});
}
