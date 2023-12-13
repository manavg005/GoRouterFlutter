part of 'payment_management_bloc.dart';

@immutable
abstract class PaymentManagementState {}

class PaymentManagementInitial extends PaymentManagementState {}

class PaymentManagementSuccessState extends PaymentManagementInitial {
  final PaymentManagementResponseModel paymentManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  PaymentManagementSuccessState(
      {required this.paymentManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
}

class PaymentManagementLoadingState extends PaymentManagementInitial {}

class PaymentManagementErrorState extends PaymentManagementInitial {
  final String errorMessage;

  PaymentManagementErrorState({required this.errorMessage});
}
