class CleanerActiveInactiveResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  CleanerActiveInactiveResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  CleanerActiveInactiveResponseModel.fromJson(Map<String, dynamic> json) {
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
  Cleaner? cleaner;

  Data({this.cleaner});

  Data.fromJson(Map<String, dynamic> json) {
    cleaner =
        json['Cleaner'] != null ? Cleaner.fromJson(json['Cleaner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cleaner != null) {
      data['Cleaner'] = cleaner!.toJson();
    }
    return data;
  }
}

class Cleaner {
  String? sId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  int? status;
  String? createdAt;
  String? updatedAt;

  Cleaner(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt});

  Cleaner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
