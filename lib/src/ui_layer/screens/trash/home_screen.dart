import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/cleaner_management/view_cleaner_details.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/banner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/cleaner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/send_notification_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/drawer_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/popup_menu.dart';

import '../../../data_layer/res/colors.dart';
import '../../widgets/app_text.dart';
import '../home_screen/booking_management.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.id});
  final String? id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: body(),
      backgroundColor: Colors.white,
    );
  }

  Widget body() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: CustomDrawer(
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
          ),
        ),
        Flexible(
          flex: 4,
          child: Scaffold(
            appBar: AppBar(
              // elevation: 50,
              backgroundColor: AppColors.whiteColor,
              actions: const [
                PopUpMenu(),
              ],
            ),
            body: getSelectedScreen(),
          ),
        ),
      ],
    );
  }

  Widget getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return SendNotificationScreen();
      case 1:
        return UserManagementScreen();
      case 2:
        return CleanerManagementScreen();
      case 3:
        return BookingManagementScreen();
      case 4:
        return PaymentManagementScreen();
      case 5:
        return NotificationManagementScreen();
      case 6:
        return BannerManagementScreen();
      case 7:
        return Center(
          child: Text("CMS"),
        );

      default:
        return Container(); // Return a default widget or an empty container
    }
  }
}
