import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../data_layer/res/numbers.dart';
import 'device_info_helper.dart';
import 'log_helper.dart';

class UtilHelper {
  UtilHelper.__internal();

  static final UtilHelper _instance = UtilHelper.__internal();

  static UtilHelper get instance => _instance;

  String fcmToken = "abc";
  double myLat = 0;
  double myLng = 0;
  bool bluetoothPermissionOpened = false;
  bool locationPermissionOpened = false;
  bool notificationScreenOpened = false;
  bool reservationDetailScreenOpened = false;
  bool updateAppBottomSheetOpened = false;
  bool sessionExpiredBottomSheetOpened = false;

  // String languageCode = LanguageConstants.englishLanguageCode;
  String versionNumber = "";

  // String _currentVersion = "";
  // final HomeRepository _homeRepository = HomeRepository();
  bool isSocialLogin = false;

  String getLocale(String locale) {
    if (locale.length > i_1) {
      return locale.substring(i_0, i_2);
    } else if (locale.length <= i_1) {
      return locale;
    } else {
      return "en";
    }
  }

  // Future<void> setVersionNumber() async {
  //   try{
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     versionNumber = ' : ${packageInfo.version} (${packageInfo.buildNumber})'; //TODO: Add text before version
  //     _currentVersion = packageInfo.version;
  //     if (FlavorConfiguration.instance.flavor == Flavors.dev) {
  //       versionNumber += ' - dev';
  //     } else if(FlavorConfiguration.instance.flavor == Flavors.qa){
  //       versionNumber += ' - testing';
  //     }
  //     LogHelper.logData(versionNumber);
  //   } catch (e){
  //     LogHelper.logError(e.toString());
  //   }
  // }

  /// Method used to parse number
  num parseNumber(String value) {
    if (value == null) return i_0;
    if (int.tryParse(value) != null) {
      return int.parse(value);
    } else if (double.tryParse(value) != null) {
      return double.parse(double.parse(value).toStringAsFixed(i_1));
    } else {
      return i_0;
    }
  }

  /// Method used to returns a same same string first letter capitalization
  String capitalize(String value) {
    if (value == null) {
      return "";
    } else {
      return value.isNotEmpty
          ? '${value[i_0].toUpperCase()}${value.substring(i_1)}'
          : "";
    }
  }

  /// Methode used to close keyboard
  void closeKeyboard(BuildContext context) {
    if (DeviceInfo.isKeyBoardOpen(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  String getError(String message) {
    return message.replaceAll("'", "");
  }

  // Future<void> openAppleOrGoogleMap(double lat, double lng) async {
  //   String url = Platform.isIOS ? ApiConstants.appleUrl(lat, lng) : ApiConstants.googleUrl(lat, lng);
  //   try{
  //     if (await canLaunchUrl(Uri.parse(url))) {
  //       await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  //     }
  //   } catch (error){
  //     LogHelper.logError(error);
  //   }
  // }

  // Future<void> openPlayStoreOrAppStore() async {
  //   String url = Platform.isIOS ? ApiConstants.appStoreUrl : ApiConstants.playStoreUrl;
  //   try{
  //     if (await canLaunchUrl(Uri.parse(url))) {
  //       await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  //     }
  //   } catch (error){
  //     LogHelper.logError(error);
  //   }
  // }

  // Future<void> launchPhoneCall() async {
  //   String url = StringConstants.supportNumber;
  //   try{
  //     if (await canLaunchUrl(Uri.parse(url))) {
  //       await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  //     }
  //   } catch (error){
  //     LogHelper.logError(error);
  //   }
  // }
  //
  // bool isAvailableNextVersion(String version){
  //   int currentVersion = int.tryParse(_currentVersion.replaceAll(".", ""));
  //   int nextVersion = int.tryParse(version?.replaceAll(".", "") ?? "");
  //   if(currentVersion != null && nextVersion != null && currentVersion < nextVersion){
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  /// Method used to open app settings if user is not allow permission while
  /// time of permission asking
  Future<void> openAppSettings() async {
    try {
      await openAppSettings();
    } on Exception catch (e) {
      LogHelper.logError("Error while open app settings===> $e");
    }
  }

  /// method used to open dialer to make a call on phone number
  void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  /// method used to open email app on tap an email address
  void sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String convertTo12HourFormat(String time24hr) {
    // Split the input time into hours and minutes
    List<String> parts = time24hr.split(':');

    if (parts.length != 2) {
      throw ArgumentError("Invalid time format: $time24hr");
    }

    int? hours = int.tryParse(parts[0]);
    int? minutes = int.tryParse(parts[1]);

    if (hours == null ||
        minutes == null ||
        hours < 0 ||
        hours > 23 ||
        minutes < 0 ||
        minutes > 59) {
      throw ArgumentError("Invalid time format: $time24hr");
    }

    // Determine if it's AM or PM
    String period = hours >= 12 ? 'PM' : 'AM';

    // Convert hours to 12-hour format
    if (hours == 0) {
      hours = 12;
    } else if (hours > 12) {
      hours -= 12;
    }

    // Format the result
    String formattedTime =
        '$hours:${minutes.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }

  String maskEmail(String email) {
    if (email == null || email.isEmpty) {
      return email;
    }

    // Split the email into local and domain parts
    List<String> parts = email.split('@');
    if (parts.length != 2) {
      // Invalid email format, return the original email
      return email;
    }

    String localPart = parts[0];
    String domainPart = parts[1];

    // Mask the characters in the local part except for the first and last character
    String maskedLocalPart = localPart[0] +
        '*' * (localPart.length - 2) +
        localPart[localPart.length - 1];

    // Combine the masked local part and domain part to form the masked email
    String maskedEmail = maskedLocalPart + '@' + domainPart;

    return maskedEmail;
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return phoneNumber;
    }

    // Remove non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D+'), '');

    // Check if there are enough digits to mask
    if (digitsOnly.length <= 4) {
      return phoneNumber; // Not enough digits to mask
    }

    // Keep the first two and last two digits as they are, replace the rest with "*"
    String maskedDigits = digitsOnly.substring(0, 2) +
        '*' * (digitsOnly.length - 4) +
        digitsOnly.substring(digitsOnly.length - 2);

    // Reconstruct the masked phone number with the same formatting
    String maskedPhoneNumber = '';
    int currentIndex = 0;

    for (int i = 0; i < phoneNumber.length; i++) {
      if (phoneNumber[i].contains(RegExp(r'\d'))) {
        maskedPhoneNumber += maskedDigits[currentIndex];
        currentIndex++;
      } else {
        maskedPhoneNumber += phoneNumber[i];
      }
    }

    return maskedPhoneNumber;
  }
}
