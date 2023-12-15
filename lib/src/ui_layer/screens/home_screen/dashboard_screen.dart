import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/dashboard/dashboard_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/home_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/popup_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  void initState() {
    _dashboardBloc.add(DashboardInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: _dashboardBloc,
        builder: (context, state) {
          if (state is DashboardLoadingState) {
            return Center(
              child: LinearProgressIndicator(),
            );
          } else if (state is DashboardSuccessState) {
            return _buildBody(context, state.homeManagementResponseModel);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  GridView _buildBody(
      BuildContext context, HomeManagementResponseModel dashboard) {
    final value = dashboard.data;
    Size screenSize = MediaQuery.of(context).size;
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 51),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            max(1, (MediaQuery.of(context).size.width ~/ 600).toInt()),
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2,
      ),
      children: [
        _buildDashboardContainer(
            heading: "Total number of users registered",
            value: value?.totalRegisteredUsers.toString() ?? "",
            image: AppImages.personGif,
            screenSize: screenSize),
        _buildDashboardContainer(
          heading: "Total number of cleaner registered",
          value: value?.totalCleaners.toString() ?? "",
          image: AppImages.cleanerGif,
          screenSize: screenSize,
        ),
        _buildDashboardContainer(
          heading: "Total number of bookings",
          value: value?.totalBookings.toString() ?? "",
          image: AppImages.bookingGif,
          screenSize: screenSize,
        ),
        _buildDashboardContainer(
          heading: "Total Revenue",
          value: "\$${value?.totalRevenue.toString().padLeft(2, "0") ?? " "}",
          image: AppImages.revenueGif,
          color: AppColors.priceGreen,
          screenSize: screenSize,
        ),
        TextButton(
            onPressed: () {
              context.go('/dashboard/change-password');
            },
            child: Text("Change Password"))
      ],
    );
  }

  Widget _buildDashboardContainer(
      {required String heading,
      required String value,
      required Widget image,
      Color color = AppColors.dashboardText,
      required Size screenSize}) {
    return SafeArea(
      child: Container(
        padding: AppStyles.pd30,
        // height: screenSize.height * 10,
        // width: 519,

        decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: AppColors.progressIndicatorBackGroundColor
            //         .withOpacity(0.15),
            //     blurRadius: 15,
            //     offset: const Offset(0, 6),
            //   ),
            // ],
            color: AppColors.containerGray,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PoppinsSemiBold600(
              text: heading,
              fontSize: 20,
              color: AppColors.dashboardText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 109,
                  width: 109,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(1000)),
                  padding: const EdgeInsets.all(20),
                  child: image,
                ),
                PoppinsSemiBoldSecond600(
                  text: value,
                  fontSize: 40,
                  color: color,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
