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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target'] = target;
    data['title'] = title;
    data['message'] = message;
    return data;
  }
}
