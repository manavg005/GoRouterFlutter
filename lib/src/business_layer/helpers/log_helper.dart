import 'dart:developer';

import 'package:logger/logger.dart';

import '../../../app_settings.dart';

/// This class is used to log data and error
class LogHelper {
  /// This method is used to log data
  static void logData(var message, {String logName = ""}) {
    if (AppSettings.disableLogs) return;
    //Logger().d(message);
    log(message);
  }

  /// This method is used to log error
  static void logError(var message, {String logName = ""}) {
    if (AppSettings.disableLogs) return;
    Logger().e(message);
  }
}
