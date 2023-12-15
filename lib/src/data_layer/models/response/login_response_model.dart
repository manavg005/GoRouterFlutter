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
  Userdata? userdata;

  Data({this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    userdata = json['data'] != null ? Userdata.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userdata != null) {
      data['data'] = userdata!.toJson();
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
        ? UserDetails.fromJson(json['userDetails'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    data['_id'] = sId;
    data['isDeleted'] = isDeleted;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['token'] = token;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    return data;
  }
}
