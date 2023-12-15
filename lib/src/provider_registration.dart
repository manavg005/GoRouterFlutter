import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/banner_management/banner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/dashboard/dashboard_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/notification_management/notification_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/user_management/user_management_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'business_layer/blocs/login_bloc/login_bloc.dart';

class RegisterBloc {
  ///Register all providers used in the application here
  static List<SingleChildWidget> blocs(BuildContext context) => [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => UserManagementBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (context) => BannerBloc(),
        )
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
