part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingManagementLoadingState extends BookingInitial {}

class BookingManagementSuccessState extends BookingInitial {
  final BookingManagementResponseModel bookingManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  BookingManagementSuccessState(
      {required this.bookingManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
}

class BookingManagementErrorState extends BookingInitial {
  final String errorMessage;

  BookingManagementErrorState({required this.errorMessage});
}
