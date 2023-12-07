import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';

class LoginInfo extends ChangeNotifier {
  LoginInfo.__internal();

  static final LoginInfo _instance = LoginInfo.__internal();

  static LoginInfo get instance => _instance;

  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    UserStateHiveHelper.instance.setIsUserLoggedIn(value);
    _isLoggedIn = value;
    notifyListeners();
  }
}
