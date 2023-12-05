class SendNotificationRequestModel {
  String? target;
  String? title;
  String? message;

  SendNotificationRequestModel({this.target, this.title, this.message});

  SendNotificationRequestModel.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target'] = this.target;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}
