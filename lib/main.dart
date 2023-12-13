import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/device_info_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/flavor_configuration_helper.dart';
import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
import 'package:keypitkleen_flutter_admin/src/provider_registration.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/app_router_configuration.dart';

// void main() async {
//   debugPaintSizeEnabled = false;
//   setPathUrlStrategy();
//   runApp(const KeyPitKleenApp());
//
//   /// run the app in a zone
//   /// this will catch all the errors in the app
//   /// and log them to the crashlytics
//   // runZonedGuarded(() async {
//   // /// initialize the widgets binding
//   // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   //   ///* Sets the status bar color of the widget */
//   //   AppStyles.setStatusBarTheme();
//   //
//   //   // screen util
//   //   await ScreenUtil.ensureScreenSize();
//   //
//   //   ///* Sets the device orientation of application */
//   //   AppStyles.setDeviceOrientationOfApp();
//   //
//   WidgetsFlutterBinding.ensureInitialized();
//
//   /// setting the server config
//   /// this will set the server config based on the flavor
//   /// see [AppSettings] for more details
//   FlavorConfig.setServerConfig();
//   //
//   //   // /// initialize the firebase
//   //   // FirebaseInitializer.instance.init();
//
//   /// initialize the hive and register the adapters
//   // await HiveHelper.initializeHiveAndRegisterAdapters();
//
//   /// generate the encryption key for secure storage
//   // await SecureStorageHelper.instance.generateEncryptionKey();
//   //
//   //   bool isOnboardingCompleted =
//   //       await UserStateHiveHelper.instance.getIsOnboardingCompleted();
//   //   print("onboarding complete==>>$isOnboardingCompleted");
//   //   bool isUserLoggedIn =
//   //       await UserStateHiveHelper.instance.getIsUserLoggedIn();
//   //
//   //   // if (isOnboardingCompleted && isUserLoggedIn) {
//   //   /// move to login screen
//   //   /// run the app
//   //   runApp(const KeyPitKleenApp(
//   //     initialScreen: LoginScreen(),
//   //   ));
//   //   // }
//   //   /*else if (isOnboardingCompleted) {
//   //     /// move to home screen
//   //     /// run the app
//   //     runApp(const KeyPitKleenApp(
//   //       initialScreen: LoginScreen(),
//   //     ));
//   //   } else {
//   //     /// move to onboarding screen
//   //     /// run the app
//   //     runApp(const KeyPitKleenApp(
//   //       initialScreen: OnboardingScreen(),
//   //     ));
//   //   }*/
//   //
//   //   /// remove the splash screen
//   //   // FlutterNativeSplash.remove();
//   // }, (error, stack) {
//   /// log the error to the crashlytics
//   // CrashlyticsHelper.instance.logError(error, stack);
//   // });
// }

import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // turn off the # in the URLs on the web
  // debugPaintSizeEnabled = true;
  usePathUrlStrategy();
  runApp(const KeyPitKleenApp());
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.setServerConfig();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo.setDeviceInfo(context);
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return MultiBlocProvider(
      providers: RegisterBloc.blocs(context),
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: false),
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
