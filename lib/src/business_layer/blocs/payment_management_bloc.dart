import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/payment_management_response.dart';
import 'package:meta/meta.dart';

part 'payment_management_event.dart';
part 'payment_management_state.dart';

class PaymentManagementBloc
    extends Bloc<PaymentManagementEvent, PaymentManagementState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  PaymentManagementResponseModel _paymentManagementResponseModel =
      PaymentManagementResponseModel();

  // int _currentPage = 1;
  PaymentManagementBloc() : super(PaymentManagementInitial()) {
    on<PaymentManagementInitialEvent>(paymentManagementInitialEvent);
    on<PaymentManagementSearchEvent>(paymentManagementSearchEvent);
  }

  Future<FutureOr<void>> paymentManagementInitialEvent(
      PaymentManagementInitialEvent event,
      Emitter<PaymentManagementState> emit) async {
    await _loadData("", 1, "yearly", "", "", emit);
  }

/*  Future<FutureOr<void>> paymentManagementLoadMoreEvent(
      PaymentManagementLoadMoreEvent event,
      Emitter<PaymentManagementState> emit) async {
    if (state is PaymentManagementSuccessState) {
      final int nextPage = _currentPage + 1;
      await _loadData("", nextPage, "yearly", emit);
    }
  }*/

  /* Future<FutureOr<void>> paymentManagementLoadPreviousEvent(
      PaymentManagementLoadPreviousEvent event,
      Emitter<PaymentManagementState> emit) async {
    if (state is PaymentManagementSuccessState) {
      final int nextPage = _currentPage - 1;
      await _loadData("", nextPage, "yearly", emit);
    }
  }*/

  Future<void> _loadData(
      String search,
      int page,
      String monthlyYearly,
      String startDate,
      String endDate,
      Emitter<PaymentManagementState> emit) async {
    emit(PaymentManagementLoadingState());

    final BaseApiResponseModel response = await _dashboardRepository
        .paymentManagement(search, page, monthlyYearly, startDate, endDate);

    if (response.data != null &&
        response.data is PaymentManagementResponseModel) {
      _paymentManagementResponseModel = response.data;

      if (_paymentManagementResponseModel.status!) {
        emit(PaymentManagementSuccessState(
            paymentManagementResponseModel: _paymentManagementResponseModel,
            hasMoreData: (_paymentManagementResponseModel
                        .data?.userData?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page));
      } else {
        emit(PaymentManagementErrorState(
          errorMessage: _paymentManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(PaymentManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<FutureOr<void>> paymentManagementSearchEvent(
      PaymentManagementSearchEvent event,
      Emitter<PaymentManagementState> emit) async {
    await _loadData(event.searchQuery, event.page, event.monthlyYearly,
        event.startDate, event.endDate, emit);
    log("I am in Search");
  }
}
