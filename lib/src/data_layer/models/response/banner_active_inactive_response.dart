class BannerActiveInactiveResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  BannerActiveInactiveResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  BannerActiveInactiveResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Banner>? banner;

  Data({this.banner});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(Banner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  String? sId;
  String? name;
  String? imageUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? iV;

  Banner(
      {this.sId,
      this.name,
      this.imageUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.iV});

  Banner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    return data;
  }
}
