import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/user_management_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_management_response.dart';

import '../../helpers/util_helper.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final UserManagementRepository _userRepository = UserManagementRepository();
  UserManagementResponseModel _userManagementResponseModel =
      UserManagementResponseModel();
  UserActiveInactiveResponseModel _activeInactiveResponseModel =
      UserActiveInactiveResponseModel();

  int _currentPage = 1;

  UserManagementBloc() : super(UserManagementInitial()) {
    on<UserManagementInitialEvent>(userManagementInitialEvent);
    on<UserActiveInactiveEvent>(userActiveInactiveEvent);
    on<UserManagementSearchEvent>(userManagementSearchEvent);
  }

  Future<void> userManagementInitialEvent(UserManagementInitialEvent event,
      Emitter<UserManagementState> emit) async {
    await _loadData("", 1, emit); // Load initial data
  }

  Future<void> _loadData(
      String search, int page, Emitter<UserManagementState> emit) async {
    emit(UserManagementLoadingState());

    final BaseApiResponseModel response =
        await _userRepository.userManagement(search, page);

    if (response.data != null && response.data is UserManagementResponseModel) {
      _userManagementResponseModel = response.data;

      if (_userManagementResponseModel.status!) {
        _currentPage = page;

        if (page == 1) {
          emit(UserManagementSuccessState(
            userManagementResponseModel: _userManagementResponseModel,
            hasMoreData: (_userManagementResponseModel
                        .data?.userData?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page,
          ));
        } else {
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
    // emit(UserManagementLoadingState());
    final BaseApiResponseModel response =
        await _userRepository.userActiveInactive(event.userId);
    if (response.data != null &&
        response.data is UserActiveInactiveResponseModel) {
      _activeInactiveResponseModel = response.data;
      if (_activeInactiveResponseModel.status!) {
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

  Future<void> userManagementSearchEvent(UserManagementSearchEvent event,
      Emitter<UserManagementState> emit) async {
    await _loadData(event.searchQuery, event.page, emit);
    log("I am in Search");
  }
}
