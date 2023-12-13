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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
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
        ? new AddBanner.fromJson(json['addBanner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addBanner != null) {
      data['addBanner'] = this.addBanner!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
