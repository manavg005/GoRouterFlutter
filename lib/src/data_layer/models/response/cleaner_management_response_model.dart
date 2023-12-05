class CleanerManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  CleanerManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  CleanerManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['data'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? totalCount;
  List<ModifiedData>? modifiedData;

  UserData({this.totalCount, this.modifiedData});

  UserData.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  Address? address;
  int? status;
  bool? isDeleted;
  int? yearOfExperience;
  String? createdAt;
  List<Specialization>? specialization;
  String? fullName;

  ModifiedData(
      {this.sId,
        this.firstName,
        this.lastName,
        this.countryCode,
        this.phoneNumber,
        this.email,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.address,
        this.status,
        this.isDeleted,
        this.yearOfExperience,
        this.createdAt,
        this.specialization,
        this.fullName});

  ModifiedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    status = json['status'];
    isDeleted = json['isDeleted'];
    yearOfExperience = json['yearOfExperience'];
    createdAt = json['createdAt'];
    if (json['specialization'] != null) {
      specialization = <Specialization>[];
      json['specialization'].forEach((v) {
        specialization!.add(Specialization.fromJson(v));
      });
    }
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneVerified'] = isPhoneVerified;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['yearOfExperience'] = yearOfExperience;
    data['createdAt'] = createdAt;
    if (specialization != null) {
      data['specialization'] =
          specialization!.map((v) => v.toJson()).toList();
    }
    data['fullName'] = fullName;
    return data;
  }
}

class Address {
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? lat;
  String? lng;

  Address(
      {this.address,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.lat,
        this.lng});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipCode'] = zipCode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Specialization {
  String? value;

  Specialization({this.value});

  Specialization.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}