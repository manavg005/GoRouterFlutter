import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data_layer/res/regex.dart';
import '../../../key_pit_kleen_app.dart';

class ValidatorHelper {
  static AppLocalizations localizations =
      AppLocalizations.of(navigatorKey.currentContext!)!;

  static bool isEmail(String input) => EmailValidator.validate(input);

  static bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  static String? validateFirstName(String? value) {
    if (value!.isNotEmpty) {
      if (value.isNotEmpty && value.length < 2) {
        return 'Message';
      }
      return null;
    }
    return localizations.first_name_validator_msg_enter_value;
  }

  static String? validateLastName(String? value) {
    if (value!.isNotEmpty) {
      if (value.isNotEmpty && value.length < 2) {
        return 'Message';
      }
      return null;
    }
    return 'Message';
  }

  static String? validateEmail(String? value) {
    if (value != null && !AppRegex.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (!(isPhone(value!) && value.length == 10)) {
      return 'Message';
    }
    return null;
  }

  static String? validateForEmailOrPhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      if (AppRegex.validPhone.hasMatch(value)) {
        /// value is a phone number
        return validatePhoneNumber(value);
      } else {
        /// value is an email
        return validateEmail(value);
      }
    }
    return null;
  }

  static String? validateEmailPhone(String? value) {
    if (!isEmail(value!) && !(isPhone(value) && value.length == 10)) {
      return 'Please enter a valid email or phone number.';
    }
    return null;
  }

  static String? validateCurrentPassword(String? value) {
    if (value!.isNotEmpty) {
      // if (value.length < 8) {
      //   return "Please enter your current password";
      // }
      return null;
    }
    return 'Please enter your current password';
  }

  static String? nonEmptyValidation(String? value, String fieldTitle) {
    if (value!.isEmpty) {
      return "$fieldTitle is required.";
    }
    return null;
  }

  static String? strongPasswordValidation(String? password) {
    if (password!.isEmpty) {
      return 'Please enter a password';
    }
    // Check if the password length is at least 8 characters
    if (password.length < 8) {
      return 'Password length should be at least 8';
    }

    // Check if the password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contains at least one uppercase letter';
    }

    // Check if the password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contains at least one lowercase letter';
    }

    // Check if the password contains at least one number
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contains at least one number';
    }

    // Check if the password contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\|/-]'))) {
      return 'Password contains at least one special character';
    }

    // If all criteria are met, the password is strong
    return null;
  }
}
