import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_management_response.dart';

import '../../helpers/util_helper.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  UserManagementResponseModel _userManagementResponseModel =
      UserManagementResponseModel();
  UserActiveInactiveResponseModel _activeInactiveResponseModel =
      UserActiveInactiveResponseModel();

  int _currentPage = 1;

  UserManagementBloc() : super(UserManagementInitial()) {
    on<UserManagementInitialEvent>(userManagementInitialEvent);
    on<UserManagementLoadMoreEvent>(userManagementLoadMoreEvent);
    on<UserManagementLoadPreviousEvent>(userManagementLoadPreviousEvent);
    on<UserActiveInactiveEvent>(userActiveInactiveEvent);
  }

  Future<void> userManagementInitialEvent(UserManagementInitialEvent event,
      Emitter<UserManagementState> emit) async {
    await _loadData(1, emit); // Load initial data
  }

  Future<void> userManagementLoadMoreEvent(UserManagementLoadMoreEvent event,
      Emitter<UserManagementState> emit) async {
    if (state is UserManagementSuccessState) {
      final int nextPage = _currentPage + 1;
      await _loadData(nextPage, emit);
    }
  }

  Future<void> userManagementLoadPreviousEvent(
      UserManagementLoadPreviousEvent event,
      Emitter<UserManagementState> emit) async {
    if (state is UserManagementSuccessState) {
      final int nextPage = _currentPage - 1;
      await _loadData(nextPage, emit);
    }
  }

  Future<void> _loadData(int page, Emitter<UserManagementState> emit) async {
    emit(UserManagementLoadingState());

    final BaseApiResponseModel response =
        await _dashboardRepository.userManagement(page);

    if (response.data != null && response.data is UserManagementResponseModel) {
      _userManagementResponseModel = response.data;

      if (_userManagementResponseModel.status!) {
        _currentPage = page;

        if (page == 1) {
          /// If it's the initial load, emit UserManagementSuccessState
          emit(UserManagementSuccessState(
              userManagementResponseModel: _userManagementResponseModel,
              hasMoreData: (_userManagementResponseModel
                          .data?.userData?.modifiedData?.length ??
                      0) >=
                  10,
              currentPage: page));
        } else {
          /// If it's a load more operation, emit UserManagementSuccessState with the new data
          emit(UserManagementSuccessState(
            userManagementResponseModel: _userManagementResponseModel,
            hasMoreData: (_userManagementResponseModel
                        .data?.userData?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page,
          ));
        }
      } else {
        emit(UserManagementErrorState(
          errorMessage: _userManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(UserManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<FutureOr<void>> userActiveInactiveEvent(
      UserActiveInactiveEvent event, Emitter<UserManagementState> emit) async {
    emit(UserManagementLoadingState());
    log("In User Active");
    final BaseApiResponseModel response =
        await _dashboardRepository.userActiveInactive(event.userId);
    if (response.data != null &&
        response.data is UserActiveInactiveResponseModel) {
      _activeInactiveResponseModel = response.data;
      if (_activeInactiveResponseModel.status!) {
        emit(UserActiveInactiveState());
      } else {
        return _activeInactiveResponseModel.msg!;
      }
    } else {
      emit(UserManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }
}
