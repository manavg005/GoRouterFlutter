// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';

class DialogUtil {
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

  static void showAlertDialog(
      BuildContext context, String title, String message, Function onTapped) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => {
                    Navigator.pop(context),
                    onTapped(),
                  },
                ),
              ],
            ),
          )
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoButton(
                  child: const Text('OK'),
                  onPressed: () => {
                    Navigator.pop(context),
                    onTapped(),
                  },
                ),
              ],
            ),
          );
  }

  static void showAlertDialogWithYesNo(
      BuildContext context, String title, String message, Function onTapped) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('YES'),
                  onPressed: () => {
                    Navigator.pop(context),
                    log("Yes Clicked"),
                    onTapped(),
                  },
                ),
                TextButton(
                  child: const Text('NO'),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                ),
              ],
            ),
          )
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoButton(
                  child: const Text('YES'),
                  onPressed: () => {
                    Navigator.pop(context),
                    onTapped(),
                  },
                ),
                CupertinoButton(
                  child: const Text('NO'),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                ),
              ],
            ),
          );
  }

  static void showLogoutConfirmationDialog(BuildContext context,
      {required Function onYes}) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Logout"),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
                TextButton(
                  child: const Text('NO'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          )
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text("Logout"),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                CupertinoButton(
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
                CupertinoButton(
                  child: const Text('NO'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
  }

  static void showDeleteAccountConfirmationDialog(BuildContext context,
      {required Function onYes}) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Delete Account",
                style: TextStyle(fontSize: 18, color: AppColors.redColor),
              ),
              content: const Text(
                'Caution: Deleting your account will result in the permanent loss of all your Seed Coins. Are you sure you want to delete your account?',
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                TextButton(
                  child: const Text('YES',
                      style: TextStyle(color: AppColors.redColor)),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
                TextButton(
                  child: const Text('NO'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          )
        : showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text(
                "Delete Account",
                style: TextStyle(fontSize: 18, color: AppColors.redColor),
              ),
              content: const Text(
                'Caution: Deleting your account will result in the permanent loss of all your Seed Coins. Are you sure you want to delete your account?',
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                CupertinoButton(
                  child: const Text('YES',
                      style: TextStyle(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w500)),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
                CupertinoButton(
                  child: const Text('NO',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.bottomNavBarBackground,
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  static void showConfirmationDialog(
      BuildContext context, String title, String message,
      {required Function onYes}) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('Okay'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
              ],
            ),
          )
        : showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoButton(
                  child: const Text('Okay'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    onYes(),
                  },
                ),
              ],
            ),
          );
  }

// static Future<void> openUrl(BuildContext context, String url) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     showSnackBar(context,
//         'Something went wrong, please check your internet or try again later');
//     throw Exception('Could not launch $url');
//   }
// }
//
// static void showRootCheckDialog(BuildContext context, RootCheck rootCheck) {
//   String rootedDeviceMessage =
//       'Your device is rooted. Please un-root your device to continue using the app.';
//   String jailBrokenDeviceMessage =
//       'Your device is jail broken. Please un-jailbreak your device to continue using the app.';
//   String message =
//       (Platform.isAndroid) ? rootedDeviceMessage : jailBrokenDeviceMessage;
//   String title =
//       (Platform.isAndroid) ? 'Rooted Device' : 'Jail-broken Device';
//
//   String developerModeMessage =
//       'Developer mode is enabled on your device. Please disable developer mode to continue using the app.';
//   String developerModeTitle = 'Developer Mode Enabled';
//   (Platform.isAndroid)
//       ? showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: Text((rootCheck == RootCheck.developerMode)
//                 ? developerModeTitle
//                 : title),
//             content: Text((rootCheck == RootCheck.developerMode)
//                 ? developerModeMessage
//                 : message),
//           ),
//         )
//       : showCupertinoDialog(
//           context: context,
//           builder: (context) => CupertinoAlertDialog(
//             title: Text((rootCheck == RootCheck.developerMode)
//                 ? developerModeTitle
//                 : title),
//             content: Text((rootCheck == RootCheck.developerMode)
//                 ? developerModeMessage
//                 : message),
//           ),
//         );
// }
}
