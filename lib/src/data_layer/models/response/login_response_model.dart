class LoginResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  LoginResponseModel({this.status, this.statusCode, this.msg, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  Userdata? userdata;

  Data({this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    userdata = json['data'] != null
        ? Userdata.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userdata != null) {
      data['data'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  UserDetails? userDetails;
  String? sId;
  bool? isDeleted;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  Userdata(
      {this.userDetails,
        this.sId,
        this.isDeleted,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.token});

  Userdata.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    sId = json['_id'];
    isDeleted = json['isDeleted'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    data['_id'] = this.sId;
    data['isDeleted'] = this.isDeleted;
    data['deletedAt'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }
}

class UserDetails {
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;

  UserDetails(
      {this.firstName,
        this.lastName,
        this.countryCode,
        this.phoneNumber,
        this.email});

  UserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
