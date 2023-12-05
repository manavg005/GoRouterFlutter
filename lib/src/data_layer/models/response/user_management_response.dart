class UserManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  UserManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  UserManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? status;
  bool? isDeleted;
  String? createdAt;
  List<Address>? address;
  String? profilePic;
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
      this.status,
      this.isDeleted,
      this.createdAt,
      this.address,
      this.profilePic,
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
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    profilePic = json['profilePic'];
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
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    return data;
  }
}

class Address {
  String? type;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? lat;
  String? lng;
  bool? isDefault;
  String? sId;

  Address(
      {this.type,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.lat,
      this.lng,
      this.isDefault,
      this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    lat = json['lat'];
    lng = json['lng'];
    isDefault = json['isDefault'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipCode'] = zipCode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['isDefault'] = isDefault;
    data['_id'] = sId;
    return data;
  }
}
