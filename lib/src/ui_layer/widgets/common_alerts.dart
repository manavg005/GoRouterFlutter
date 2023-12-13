import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';

class AlertHelper {
  static void showToast(
    String message,
  ) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        textColor: AppColors.whiteColor,
        webShowClose: true,
        webBgColor: AppColors.blueLinearGradient,
        fontSize: 16.0);
  }

  static void showToastMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.blackColor,
        textColor: Colors.white,
        fontSize: 16.0,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        webPosition: "right",
      );
}
