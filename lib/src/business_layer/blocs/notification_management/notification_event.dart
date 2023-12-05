part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class NotificationInitialEvent extends NotificationEvent {}

class NotificationLoadMoreEvent extends NotificationEvent {}

class NotificationLoadPreviousEvent extends NotificationEvent {}

class SendNotificationEvent extends NotificationEvent {
  final SendNotificationRequestModel sendNotificationRequestModel;

  SendNotificationEvent({required this.sendNotificationRequestModel});
}
