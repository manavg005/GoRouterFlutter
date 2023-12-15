import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/dialog_util.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/send_notification_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/notification_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/send_notification_response.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  NotificationManagementResponseModel _notificationManagementResponseModel =
      NotificationManagementResponseModel();
  SendNotificationResponseModel _notiResponseModel =
      SendNotificationResponseModel();

  int _currentPage = 1;
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationInitialEvent>(notificationInitialEvent);
    on<NotificationLoadMoreEvent>(notificationLoadMoreEvent);
    on<NotificationLoadPreviousEvent>(notificationLoadPreviousEvent);
    on<SendNotificationEvent>(sendNotificationEvent);
  }

  FutureOr<void> notificationInitialEvent(
      NotificationInitialEvent event, Emitter<NotificationState> emit) async {
    await _loadData(1, emit); // Load initial data
  }

  Future<FutureOr<void>> notificationLoadMoreEvent(
      NotificationLoadMoreEvent event, Emitter<NotificationState> emit) async {
    if (state is NotificationSuccessState) {
      final int nextPage = _currentPage + 1;
      await _loadData(nextPage, emit);
    }
  }

  FutureOr<void> notificationLoadPreviousEvent(
      NotificationLoadPreviousEvent event,
      Emitter<NotificationState> emit) async {
    if (state is NotificationSuccessState) {
      final int nextPage = _currentPage - 1;
      await _loadData(nextPage, emit);
    }
  }

  Future<void> _loadData(int page, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());

    final BaseApiResponseModel response =
        await _dashboardRepository.notificationManagement(page);

    if (response.data != null &&
        response.data is NotificationManagementResponseModel) {
      _notificationManagementResponseModel = response.data;

      if (_notificationManagementResponseModel.status!) {
        _currentPage = page;

        emit(NotificationSuccessState(
            notificationManagementResponseModel:
                _notificationManagementResponseModel,
            hasMoreData: (_notificationManagementResponseModel
                        .data?.modifiedData?.userdata?.length ??
                    0) >=
                10,
            currentPage: page));
      } else {
        emit(NotificationErrorState(
          errorMessage: _notificationManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(NotificationErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<FutureOr<void>> sendNotificationEvent(
      SendNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());
    final BaseApiResponseModel response = await _dashboardRepository
        .sendNotification(event.sendNotificationRequestModel);
    if (response.data != null &&
        response.data is SendNotificationResponseModel) {
      _notiResponseModel = response.data;
      DialogUtil.showToast(_notiResponseModel.msg!);
    } else {
      emit(NotificationErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
  }
}
