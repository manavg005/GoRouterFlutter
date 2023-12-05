class PaymentManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  PaymentManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  PaymentManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? bookingId;
  int? amount;
  String? paymentId;
  int? status;
  String? createdAt;
  Null? customer;

  ModifiedData(
      {this.sId,
        this.bookingId,
        this.amount,
        this.paymentId,
        this.status,
        this.createdAt,
        this.customer});

  ModifiedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookingId = json['bookingId'];
    amount = json['amount'];
    paymentId = json['paymentId'];
    status = json['status'];
    createdAt = json['createdAt'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bookingId'] = bookingId;
    data['amount'] = amount;
    data['paymentId'] = paymentId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['customer'] = customer;
    return data;
  }
}