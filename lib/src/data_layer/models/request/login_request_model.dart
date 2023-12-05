class LoginRequestModel {
  String? email;
  String? password;
  String? deviceId;
  String? deviceToken;
  String? deviceType;

  LoginRequestModel(
      {this.email,
        this.password,
        this.deviceId,
        this.deviceToken,
        this.deviceType});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['deviceId'] = deviceId;
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
    return data;
  }
}