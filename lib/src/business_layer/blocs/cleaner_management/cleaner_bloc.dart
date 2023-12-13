import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/dashboard_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_management_response_model.dart';

import 'cleaner_bloc.dart';

part 'cleaner_event.dart';
part 'cleaner_state.dart';

class CleanerManagementBloc
    extends Bloc<CleanerManagementEvent, CleanerManagementState> {
  final DashboardRepository _dashboardRepository = DashboardRepository();
  CleanerManagementResponseModel _cleanerManagementResponseModel =
      CleanerManagementResponseModel();
  CleanerActiveInactiveResponseModel _activeInactiveResponseModel =
      CleanerActiveInactiveResponseModel();

  int _currentPage = 1;

  CleanerManagementBloc() : super(CleanerManagementInitial()) {
    on<CleanerManagementInitialEvent>(cleanerManagementInitialEvent);
    // on<CleanerManagementLoadMoreEvent>(cleanerManagementLoadMoreEvent);
    // on<CleanerManagementLoadPreviousEvent>(cleanerManagementLoadPreviousEvent);
    on<CleanerManagementSearchEvent>(cleanerManagementSearchEvent);
    on<CleanerActiveInactiveEvent>(cleanerActiveInactiveEvent);
  }

  Future<void> cleanerManagementInitialEvent(
      CleanerManagementInitialEvent event,
      Emitter<CleanerManagementState> emit) async {
    await _loadData("", 1, emit); // Load initial data
  }

  Future<void> cleanerManagementLoadMoreEvent(
      CleanerManagementLoadMoreEvent event,
      Emitter<CleanerManagementState> emit) async {
    if (state is CleanerManagementSuccessState) {
      final int nextPage = _currentPage + 1;
      await _loadData("", nextPage, emit);
    }
  }

  Future<void> cleanerManagementLoadPreviousEvent(
      CleanerManagementLoadPreviousEvent event,
      Emitter<CleanerManagementState> emit) async {
    if (state is CleanerManagementSuccessState) {
      final int nextPage = _currentPage - 1;
      await _loadData("", nextPage, emit);
    }
  }

  Future<void> _loadData(
      String search, int page, Emitter<CleanerManagementState> emit) async {
    emit(CleanerManagementLoadingState());

    final BaseApiResponseModel response =
        await _dashboardRepository.cleanerManagement(search, page);

    if (response.data != null &&
        response.data is CleanerManagementResponseModel) {
      _cleanerManagementResponseModel = response.data;

      if (_cleanerManagementResponseModel.status!) {
        _currentPage = page;

        if (page == 1) {
          /// If it's the initial load, emit CleanerManagementSuccessState
          emit(CleanerManagementSuccessState(
              cleanerManagementResponseModel: _cleanerManagementResponseModel,
              hasMoreData: (_cleanerManagementResponseModel
                          .data?.userData?.modifiedData?.length ??
                      0) >=
                  10,
              currentPage: page));
        } else {
          /// If it's a load more operation, emit CleanerManagementSuccessState with the new data
          emit(CleanerManagementSuccessState(
            cleanerManagementResponseModel: _cleanerManagementResponseModel,
            hasMoreData: (_cleanerManagementResponseModel
                        .data?.userData?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page,
          ));
        }
      } else {
        emit(CleanerManagementErrorState(
          errorMessage: _cleanerManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(CleanerManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<void> cleanerManagementSearchEvent(CleanerManagementSearchEvent event,
      Emitter<CleanerManagementState> emit) async {
    await _loadData(event.searchQuery, event.page, emit);
    log("I am in Search");
  }

  Future<FutureOr<void>> cleanerActiveInactiveEvent(
      CleanerActiveInactiveEvent event,
      Emitter<CleanerManagementState> emit) async {
    // emit(UserManagementLoadingState());
    final BaseApiResponseModel response =
        await _dashboardRepository.cleanerActiveInactive(event.userId);
    if (response.data != null &&
        response.data is CleanerActiveInactiveResponseModel) {
      _activeInactiveResponseModel = response.data;
      if (_activeInactiveResponseModel.status!) {
      } else {
        return _activeInactiveResponseModel.msg!;
      }
    } else {
      emit(CleanerManagementErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }
}
