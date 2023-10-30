import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'business_layer/providers/base_provider.dart';

class RegisterProviders {
  ///Register all providers used in the application here
  static List<SingleChildWidget> providers(BuildContext context) => [
        ChangeNotifierProvider<BaseProvider>(
          create: (context) => BaseProvider(),
        ),
        // ChangeNotifierProvider<BottomNavProvider>(
        //   create: (context) => BottomNavProvider(),
        // ),
        // ChangeNotifierProvider<HomeProvider>(
        //   create: (context) => HomeProvider(),
        // ),
        // ChangeNotifierProvider<LoginSignupProvider>(
        //   create: (context) => LoginSignupProvider(),
        // ),
        // ChangeNotifierProvider<CreateBookingsProvider>(
        //   create: (context) => CreateBookingsProvider(),
        // ),
        // ChangeNotifierProvider<LocationProvider>(
        //   create: (context) => LocationProvider(),
        // ),
        // ChangeNotifierProvider<ProfileProvider>(
        //   create: (context) => ProfileProvider(),
        // ),
        // ChangeNotifierProvider<MyBookingsProvider>(
        //   create: (context) => MyBookingsProvider(),
        // ),
        // ChangeNotifierProvider<PaymentProvider>(
        //   create: (context) => PaymentProvider(),
        // ),
      ];
}
