import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/dialog_util.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/util_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/repositories/banner_management_repository.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/base/base_api_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/add_banner_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/add_banner_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/banner_active_inactive_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/banner_management_response.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository _bannerRepository = BannerRepository();

  BannerManagementResponseModel _bannerManagementResponseModel =
      BannerManagementResponseModel();
  AddBannerResponseModel _addBannerResponseModel = AddBannerResponseModel();
  BannerActiveInactiveResponseModel _activeInactiveResponseModel =
      BannerActiveInactiveResponseModel();

  int _currentPage = 1;
  BannerBloc() : super(BannerInitial()) {
    on<BannerInitialEvent>(bannerInitialEvent);
    on<BannerSearchEvent>(bannerSearchEvent);
    on<BannerActiveInactive>(bannerActiveInactive);
    on<AddBannerEvent>(addBannerEvent);
  }

  Future<FutureOr<void>> bannerInitialEvent(
      BannerInitialEvent event, Emitter<BannerState> emit) async {
    await _loadData("", 1, emit);
  }

  Future<FutureOr<void>> bannerSearchEvent(
      BannerSearchEvent event, Emitter<BannerState> emit) async {
    await _loadData(event.searchQuery, event.page, emit);
  }

  FutureOr<void> bannerActiveInactive(
      BannerActiveInactive event, Emitter<BannerState> emit) async {
    final BaseApiResponseModel response =
        await _bannerRepository.bannerActiveInactive(event.bannerId);
    if (response.data != null &&
        response.data is BannerActiveInactiveResponseModel) {
      _activeInactiveResponseModel = response.data;
      if (_activeInactiveResponseModel.status!) {
        DialogUtil.showToast(_activeInactiveResponseModel.msg!);
        emit(BannerNavigateActionState());
      } else {
        // return _activeInactiveResponseModel.msg!;
      }
    } else {
      emit(BannerErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<void> _loadData(
      String search, int page, Emitter<BannerState> emit) async {
    emit(BannerLoadingState());

    final BaseApiResponseModel response =
        await _bannerRepository.bannerManagement(page, search);

    if (response.data != null &&
        response.data is BannerManagementResponseModel) {
      _bannerManagementResponseModel = response.data;

      if (_bannerManagementResponseModel.status!) {
        _currentPage = page;

        emit(BannerSuccessState(
            bannerManagementResponseModel: _bannerManagementResponseModel,
            hasMoreData: (_bannerManagementResponseModel
                        .data?.bannerData?.modifiedData?.length ??
                    0) >=
                10,
            currentPage: page));
      } else {
        emit(BannerErrorState(
          errorMessage: _bannerManagementResponseModel.msg!,
        ));
      }
    } else {
      emit(BannerErrorState(
        errorMessage: UtilHelper.instance.getExceptionMessage(
          exceptionType: response.exceptionType,
        ),
      ));
    }
  }

  Future<FutureOr<void>> addBannerEvent(
      AddBannerEvent event, Emitter<BannerState> emit) async {
    emit(BannerLoadingState());
    final BaseApiResponseModel response =
        await _bannerRepository.addBanner(event.bannerImageRequestModel);
    log("in add banner");
    if (response.data != null && response.data is AddBannerResponseModel) {
      log("in add banner response");
      _addBannerResponseModel = response.data;
      DialogUtil.showToast(_addBannerResponseModel.msg!);
      emit(BannerNavigateActionState());
    } else {
      emit(BannerErrorState(
          errorMessage: UtilHelper.instance
              .getExceptionMessage(exceptionType: response.exceptionType)));
    }
  }
}
