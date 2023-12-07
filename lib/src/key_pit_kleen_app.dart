import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keypitkleen_flutter_admin/src/provider_registration.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/app_router_configuration.dart';
import 'business_layer/helpers/device_info_helper.dart';
import 'business_layer/helpers/log_helper.dart';

/// Navigator key is to get the current context, state and widget of the
/// Material App
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// App is the root widget of the application
class KeyPitKleenApp extends StatefulWidget {
  const KeyPitKleenApp({
    super.key,
    // /*required this.initialScreen*/
  });

  // final Widget initialScreen;

  @override
  State<KeyPitKleenApp> createState() => _KeyPitKleenAppState();
}

class _KeyPitKleenAppState extends State<KeyPitKleenApp>
    with WidgetsBindingObserver {
  final String _tag = "KeyPitKleenApp:";

  @override
  void initState() {
    super.initState();

    /// Add observer to listen app lifecycle and locale changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    /// Remove observer before widget dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    LogHelper.logData("$_tag AppLifecycleState ===> $state");
    switch (state) {
      case AppLifecycleState.paused:

        /// Do something when app goes in background state
        break;
      case AppLifecycleState.resumed:

        /// Do something when app opens from background state
        break;
      case AppLifecycleState.inactive:

        /// Do something when app goes in minimized state
        break;
      case AppLifecycleState.detached:

        /// Do something when app goes in killed state
        break;
      default:

        /// Do nothing
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo.setDeviceInfo(context);
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return MultiBlocProvider(
      providers: RegisterBloc.blocs(context),
      child: MaterialApp.router(
        routerConfig: goRouter,
        title: 'KeyPitKleen',
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.app_name,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
