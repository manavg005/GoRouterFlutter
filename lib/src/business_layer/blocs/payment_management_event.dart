part of 'payment_management_bloc.dart';

@immutable
abstract class PaymentManagementEvent {}

class PaymentManagementInitialEvent extends PaymentManagementEvent {}

class PaymentManagementLoadMoreEvent extends PaymentManagementEvent {}

class PaymentManagementLoadPreviousEvent extends PaymentManagementEvent {}

class PaymentManagementSearchEvent extends PaymentManagementEvent {
  final String searchQuery;
  final int page;
  final String monthlyYearly;
  final String startDate;
  final String endDate;

  PaymentManagementSearchEvent({
    required this.searchQuery,
    required this.page,
    required this.monthlyYearly,
    required this.startDate,
    required this.endDate,
  });
}
