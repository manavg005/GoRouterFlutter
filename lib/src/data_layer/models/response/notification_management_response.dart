class NotificationManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  NotificationManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  NotificationManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  ModifiedData? modifiedData;

  Data({this.modifiedData});

  Data.fromJson(Map<String, dynamic> json) {
    modifiedData = json['modifiedData'] != null
        ? ModifiedData.fromJson(json['modifiedData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modifiedData != null) {
      data['modifiedData'] = modifiedData!.toJson();
    }
    return data;
  }
}

class ModifiedData {
  int? totalCount;
  List<UserData>? userdata;

  ModifiedData({this.totalCount, this.userdata});

  ModifiedData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['data'] != null) {
      userdata = <UserData>[];
      json['data'].forEach((v) {
        userdata!.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (userdata != null) {
      data['data'] = userdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? sId;
  String? target;
  String? title;
  String? message;
  String? createdAt;

  UserData({this.sId, this.target, this.title, this.message, this.createdAt});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    target = json['target'];
    title = json['title'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['target'] = target;
    data['title'] = title;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}