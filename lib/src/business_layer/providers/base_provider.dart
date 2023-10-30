import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../key_pit_kleen_app.dart';
import '../helpers/internet_helper.dart';
import '../network/request_response_type.dart';

class BaseProvider extends ChangeNotifier {
  ///* Function to check internet connection */
  Future<bool> checkInternet() async {
    return await NetworkConnection.instance.checkInternetConnection();
  }

  /// function to get exception message on the bases of exception type
  /// Method used to get exception messages
  String? getExceptionMessage({required ExceptionType? exceptionType}) {
    AppLocalizations localizations =
        AppLocalizations.of(navigatorKey.currentContext!)!;
    switch (exceptionType) {
      case ExceptionType.apiException:
        return localizations.api_exception_message;
      case ExceptionType.timeOutException:
        return localizations.timeOut_exception_message;
      case ExceptionType.socketException:
        return localizations.socket_exception_message;
      case ExceptionType.parseException:
        return localizations.parse_exception_message;
      case ExceptionType.otherException:
        return localizations.other_exception_message;
      case ExceptionType.cancelException:
        return localizations.cancel_exception_message;
      case ExceptionType.noException:
        return "";
      default:
        return localizations.something_wrong;
    }
  }

  /// function to logout the user
// void logout() {
//   UserStateHiveHelper.instance.logOut();
// }
}
