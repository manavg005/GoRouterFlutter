import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/dashboard/dashboard_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/notification_management/notification_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/user_management/user_management_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/login_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:provider/single_child_widget.dart';

import 'business_layer/blocs/login_bloc/login_bloc.dart';

class RegisterBloc {
  ///Register all providers used in the application here
  static List<SingleChildWidget> blocs(BuildContext context) => [
        BlocProvider(
          create: (context) => LoginBloc(),
          child: LoginScreen(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => UserManagementBloc(),
          child: UserManagementScreen(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
          child: NotificationManagementScreen(),
        ),
        // ChangeNotifierProvider<BaseProvider>(
        //   create: (context) => BaseProvider(),
        // ),
        // ChangeNotifierProvider<DashboardProvider>(
        //   create: (context) => DashboardProvider(),
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
