part of 'banner_bloc.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerActionState extends BannerState {}

class BannerSuccessState extends BannerInitial {
  final BannerManagementResponseModel bannerManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  BannerSuccessState(
      {required this.bannerManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
}

class BannerLoadingState extends BannerInitial {}

class BannerErrorState extends BannerInitial {
  final String errorMessage;

  BannerErrorState({required this.errorMessage});
}

class BannerNavigateActionState extends BannerActionState {}
