class CommonResponse {
  bool? status;
  int? statusCode;
  String? msg;

  CommonResponse({this.status, this.statusCode, this.msg});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    msg = json['msg'] != null ? json['msg'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    return data;
  }
}
