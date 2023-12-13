part of 'banner_bloc.dart';

@immutable
abstract class BannerEvent {}

class BannerInitialEvent extends BannerEvent {}

class BannerSearchEvent extends BannerEvent {
  final String searchQuery;
  final int page;

  BannerSearchEvent({required this.searchQuery, required this.page});
}

class BannerActiveInactive extends BannerEvent {
  final String bannerId;

  BannerActiveInactive({required this.bannerId});
}

class AddBannerEvent extends BannerEvent {
  final UploadBannerImageRequestModel bannerImageRequestModel;

  AddBannerEvent({required this.bannerImageRequestModel});
}

class BannerFilePicked extends BannerEvent {
  final Uint8List fileBytes;

  BannerFilePicked({required this.fileBytes});
}
