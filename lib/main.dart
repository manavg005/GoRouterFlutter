import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/flavor_configuration_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/hive_database_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen.dart';

void main() async {
  runApp(const KeyPitKleenApp());

  /// run the app in a zone
  /// this will catch all the errors in the app
  /// and log them to the crashlytics
  // runZonedGuarded(() async {
  //   /// initialize the widgets binding
  //   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //   // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //   ///* Sets the status bar color of the widget */
  //   AppStyles.setStatusBarTheme();
  //
  //   // screen util
  //   await ScreenUtil.ensureScreenSize();
  //
  //   ///* Sets the device orientation of application */
  //   AppStyles.setDeviceOrientationOfApp();
  //
  //   /// setting the server config
  //   /// this will set the server config based on the flavor
  //   /// see [AppSettings] for more details
  //   FlavorConfig.setServerConfig();
  //
  //   // /// initialize the firebase
  //   // FirebaseInitializer.instance.init();
  //
  //   /// initialize the hive and register the adapters
  //   await HiveHelper.initializeHiveAndRegisterAdapters();
  //
  //   /// generate the encryption key for secure storage
  //   await SecureStorageHelper.instance.generateEncryptionKey();
  //
  //   bool isOnboardingCompleted =
  //       await UserStateHiveHelper.instance.getIsOnboardingCompleted();
  //   print("onboarding complete==>>$isOnboardingCompleted");
  //   bool isUserLoggedIn =
  //       await UserStateHiveHelper.instance.getIsUserLoggedIn();
  //
  //   // if (isOnboardingCompleted && isUserLoggedIn) {
  //   /// move to login screen
  //   /// run the app
  //   runApp(const KeyPitKleenApp(
  //     initialScreen: LoginScreen(),
  //   ));
  //   // }
  //   /*else if (isOnboardingCompleted) {
  //     /// move to home screen
  //     /// run the app
  //     runApp(const KeyPitKleenApp(
  //       initialScreen: LoginScreen(),
  //     ));
  //   } else {
  //     /// move to onboarding screen
  //     /// run the app
  //     runApp(const KeyPitKleenApp(
  //       initialScreen: OnboardingScreen(),
  //     ));
  //   }*/
  //
  //   /// remove the splash screen
  //   // FlutterNativeSplash.remove();
  // }, (error, stack) {
  //   /// log the error to the crashlytics
  //   // CrashlyticsHelper.instance.logError(error, stack);
  // });
}
