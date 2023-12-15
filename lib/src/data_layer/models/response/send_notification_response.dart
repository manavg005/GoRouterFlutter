class SendNotificationResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  SendNotificationResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  SendNotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  AddNotification? addNotification;

  Data({this.addNotification});

  Data.fromJson(Map<String, dynamic> json) {
    addNotification = json['addNotification'] != null
        ? AddNotification.fromJson(json['addNotification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addNotification != null) {
      data['addNotification'] = addNotification!.toJson();
    }
    return data;
  }
}

class AddNotification {
  String? target;
  String? title;
  String? message;
  String? createdAt;
  String? sId;
  int? iV;

  AddNotification(
      {this.target,
      this.title,
      this.message,
      this.createdAt,
      this.sId,
      this.iV});

  AddNotification.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    title = json['title'];
    message = json['message'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target'] = target;
    data['title'] = title;
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
