import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/device_info_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/flavor_configuration_helper.dart';
import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
import 'package:keypitkleen_flutter_admin/src/provider_registration.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/app_router_configuration.dart';
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
        // theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
