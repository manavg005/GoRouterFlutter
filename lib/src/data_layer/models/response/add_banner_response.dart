class AddBannerResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  AddBannerResponseModel({this.status, this.statusCode, this.msg, this.data});

  AddBannerResponseModel.fromJson(Map<String, dynamic> json) {
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
  AddBanner? addBanner;

  Data({this.addBanner});

  Data.fromJson(Map<String, dynamic> json) {
    addBanner = json['addBanner'] != null
        ? AddBanner.fromJson(json['addBanner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addBanner != null) {
      data['addBanner'] = addBanner!.toJson();
    }
    return data;
  }
}

class AddBanner {
  String? name;
  String? imageUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? sId;
  int? iV;

  AddBanner(
      {this.name,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.sId,
      this.iV});

  AddBanner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
