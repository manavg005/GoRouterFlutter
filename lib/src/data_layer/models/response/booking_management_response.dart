class BookingManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  BookingManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  BookingManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserData? userdata;

  Data({this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    userdata = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userdata != null) {
      data['data'] = userdata!.toJson();
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
  ServiceAddress? serviceAddress;
  String? amount;
  String? scheduleDate;
  String? scheduleTime;
  PropertyType? propertyType;
  int? noOfFloor;
  PropertyType? bedrooms;
  PropertyType? bathroom;
  PropertyType? totalSquareFeet;
  PropertyType? lastCleaning;
  PropertyType? pets;
  List<ExtraServices>? extraServices;
  PropertyType? oftenUsed;
  String? status;
  String? createdAt;
  String? email;
  String? phoneNumber;
  String? profilePic;
  String? customer;
  String? cleaner;

  ModifiedData(
      {this.sId,
        this.serviceAddress,
        this.amount,
        this.scheduleDate,
        this.scheduleTime,
        this.propertyType,
        this.noOfFloor,
        this.bedrooms,
        this.bathroom,
        this.totalSquareFeet,
        this.lastCleaning,
        this.pets,
        this.extraServices,
        this.oftenUsed,
        this.status,
        this.createdAt,
        this.email,
        this.phoneNumber,
        this.profilePic,
        this.customer,
        this.cleaner});

  ModifiedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    serviceAddress = json['serviceAddress'] != null
        ? ServiceAddress.fromJson(json['serviceAddress'])
        : null;
    amount = json['amount'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    propertyType = json['propertyType'] != null
        ? PropertyType.fromJson(json['propertyType'])
        : null;
    noOfFloor = json['noOfFloor'];
    bedrooms = json['bedrooms'] != null
        ? PropertyType.fromJson(json['bedrooms'])
        : null;
    bathroom = json['bathroom'] != null
        ? PropertyType.fromJson(json['bathroom'])
        : null;
    totalSquareFeet = json['totalSquareFeet'] != null
        ? PropertyType.fromJson(json['totalSquareFeet'])
        : null;
    lastCleaning = json['lastCleaning'] != null
        ? PropertyType.fromJson(json['lastCleaning'])
        : null;
    pets =
    json['pets'] != null ? PropertyType.fromJson(json['pets']) : null;
    if (json['extraServices'] != null) {
      extraServices = <ExtraServices>[];
      json['extraServices'].forEach((v) {
        extraServices!.add(ExtraServices.fromJson(v));
      });
    }
    oftenUsed = json['oftenUsed'] != null
        ? PropertyType.fromJson(json['oftenUsed'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    customer = json['customer'];
    cleaner = json['cleaner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (serviceAddress != null) {
      data['serviceAddress'] = serviceAddress!.toJson();
    }
    data['amount'] = amount;
    data['scheduleDate'] = scheduleDate;
    data['scheduleTime'] = scheduleTime;
    if (propertyType != null) {
      data['propertyType'] = propertyType!.toJson();
    }
    data['noOfFloor'] = noOfFloor;
    if (bedrooms != null) {
      data['bedrooms'] = bedrooms!.toJson();
    }
    if (bathroom != null) {
      data['bathroom'] = bathroom!.toJson();
    }
    if (totalSquareFeet != null) {
      data['totalSquareFeet'] = totalSquareFeet!.toJson();
    }
    if (lastCleaning != null) {
      data['lastCleaning'] = lastCleaning!.toJson();
    }
    if (pets != null) {
      data['pets'] = pets!.toJson();
    }
    if (extraServices != null) {
      data['extraServices'] =
          extraServices!.map((v) => v.toJson()).toList();
    }
    if (oftenUsed != null) {
      data['oftenUsed'] = oftenUsed!.toJson();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['profilePic'] = profilePic;
    data['customer'] = customer;
    data['cleaner'] = cleaner;
    return data;
  }
}

class ServiceAddress {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? lat;
  String? lng;

  ServiceAddress(
      {this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.lat,
        this.lng});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipCode'] = zipCode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class PropertyType {
  String? name;
  String? price;

  PropertyType({this.name, this.price});

  PropertyType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ExtraServices {
  String? name;
  String? sId;

  ExtraServices({this.name, this.sId});

  ExtraServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['_id'] = sId;
    return data;
  }
}