class ChangePasswordRequestModel {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordRequestModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword
  });

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}