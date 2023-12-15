class BannerManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  BannerManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  BannerManagementResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  BannerData? bannerData;

  Data({this.bannerData});

  Data.fromJson(Map<String, dynamic> json) {
    bannerData =
        json['data'] != null ? BannerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bannerData != null) {
      data['data'] = bannerData!.toJson();
    }
    return data;
  }
}

class BannerData {
  int? totalCount;
  List<ModifiedData>? modifiedData;

  BannerData({this.totalCount, this.modifiedData});

  BannerData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['modifiedData'] != null) {
      modifiedData = <ModifiedData>[];
      json['modifiedData'].forEach((v) {
        modifiedData!.add(ModifiedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (modifiedData != null) {
      data['modifiedData'] = modifiedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModifiedData {
  String? sId;
  String? name;
  String? imageUrl;
  int? status;
  String? createdAt;

  ModifiedData(
      {this.sId, this.name, this.imageUrl, this.status, this.createdAt});

  ModifiedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }
}
