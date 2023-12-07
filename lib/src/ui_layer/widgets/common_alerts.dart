import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';

class AlertHelper {
  static Future<bool?> showToast(
    String message,
  ) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        textColor: AppColors.whiteColor,
        webShowClose: true,
        webBgColor: AppColors.blueLinearGradient,
        fontSize: 16.0);
  }
}
