class CommonResponse {
  bool? status;
  int? statusCode;
  String? msg;

  CommonResponse({this.status, this.statusCode, this.msg});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['msg'] = msg;
    return data;
  }
}
