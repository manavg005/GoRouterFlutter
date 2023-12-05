class HomeManagementResponseModel {
  bool? status;
  int? statusCode;
  String? msg;
  Data? data;

  HomeManagementResponseModel(
      {this.status, this.statusCode, this.msg, this.data});

  HomeManagementResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? totalRegisteredUsers;
  int? totalCleaners;
  int? totalBookings;
  double? totalRevenue;

  Data(
      {this.totalRegisteredUsers,
        this.totalCleaners,
        this.totalBookings,
        this.totalRevenue});

  Data.fromJson(Map<String, dynamic> json) {
    totalRegisteredUsers = json['totalRegisteredUsers'];
    totalCleaners = json['totalCleaners'];
    totalBookings = json['totalBookings'];
    totalRevenue = json['totalRevenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalRegisteredUsers'] = totalRegisteredUsers;
    data['totalCleaners'] = totalCleaners;
    data['totalBookings'] = totalBookings;
    data['totalRevenue'] = totalRevenue;
    return data;
  }
}