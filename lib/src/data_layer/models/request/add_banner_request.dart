import 'dart:typed_data';

import 'package:dio/dio.dart';

class UploadBannerImageRequestModel {
  UploadBannerImageRequestModel({this.file, this.bannerName});

  Uint8List? file;
  String? bannerName;

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (file != null && bannerName != null)
        'file': MultipartFile.fromBytes(file!,
            filename: 'image${DateTime.now().microsecondsSinceEpoch}.png'),
      'name': bannerName,
    });
  }
}
