import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/booking_management_response.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  BookingManagementResponseModel _bookingManagementResponseModel =
      BookingManagementResponseModel();

  // int _currentPage = 1;

  BookingBloc() : super(BookingInitial()) {
    on<BookingManagementInitialEvent>(bookingManagementInitialEvent);
    on<BookingManagementSearchEvent>(bookingManagementSearchEvent);
  }

  FutureOr<void> bookingManagementInitialEvent(
      BookingManagementInitialEvent event, Emitter<BookingState> emit) async {
    await _loadData(1, "", 0, emit);
  }

  Future<FutureOr<void>> bookingManagementSearchEvent(
      BookingManagementSearchEvent event, Emitter<BookingState> emit) async {
    await _loadData(event.page, event.searchQuery, event.status, emit);
  }

  Future<void> _loadData(
      int page, String search, int status, Emitter<BookingState> emit) async {
    emit(BookingManagementLoadingState());

    final BaseApiResponseModel response =
        await _dashboardRepository.bookingManagement(status, search, page);

    if (response.data != null &&
        response.data is BookingManagementResponseModel) {
      _bookingManagementResponseModel = response.data;

      if (_bookingManagementResponseModel.status!) {
        // _currentPage = page;
        emit(BookingManagementSuccessState(
            bookingManagementResponseModel: _bookingManagementResponseModel,
            hasMoreData: (_bookingManagementResponseModel
                        .data?.userdata?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page));
      } else {
        emit(BookingManagementErrorState(
          errorMessage: _bookingManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(BookingManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }
}
