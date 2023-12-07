import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/home_management_response.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  HomeManagementResponseModel _homeManagementResponseModel =
      HomeManagementResponseModel();

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(dashboardInitialEvent);
  }

  Future<FutureOr<void>> dashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    final BaseApiResponseModel response =
        await _dashboardRepository.homeManagement();
    if (response.data != null && response.data is HomeManagementResponseModel) {
      _homeManagementResponseModel = response.data;
      if (_homeManagementResponseModel.status!) {
        emit(DashboardSuccessState(
            homeManagementResponseModel: _homeManagementResponseModel));
      } else {
        return _homeManagementResponseModel.msg!;
      }
    } else {
      emit(DashboardErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
  }
}
