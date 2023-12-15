class ForgotPasswordResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  ForgotPasswordResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  int? timestamp;
  String? createdAt;
  String? sId;
  int? iV;
  String? token;

  Data(
      {this.userId,
      this.timestamp,
      this.createdAt,
      this.sId,
      this.iV,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    timestamp = json['timestamp'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['timestamp'] = timestamp;
    data['createdAt'] = createdAt;
    data['_id'] = sId;
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}
