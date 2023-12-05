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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['timestamp'] = this.timestamp;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }
}
