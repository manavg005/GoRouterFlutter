part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class BookingManagementInitialEvent extends BookingEvent {}

class BookingManagementSearchEvent extends BookingEvent {
  final String searchQuery;
  final int status;
  final int page;

  BookingManagementSearchEvent(
      {required this.searchQuery, required this.status, required this.page});
}
