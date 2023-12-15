import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../key_pit_kleen_app.dart';

class AppConstants {
  static (String, String) onboardingTitles(int index) {
    AppLocalizations localizations =
        AppLocalizations.of(navigatorKey.currentContext!)!;
    switch (index) {
      case 0:
        return (
          localizations.book_an_appointment,
          localizations.book_an_appointment_onboarding_message
        );
      case 1:
        return (
          localizations.enjoy_service_at_home,
          localizations.enjoy_service_at_home_onboarding_message
        );
      case 2:
        return (
          localizations.enjoy_service_at_home,
          localizations.enjoy_service_at_home_onboarding_message
        );
      case 3:
        return (
          localizations.enjoy_service_at_home,
          localizations.enjoy_service_at_home_onboarding_message
        );
      default:
        return ("", "");
    }
  }
}
