import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 41, vertical: 51),
      child: Column(
        children: [
          Row(
            children: [
              buildDashboardContainer(
                heading: "Total number of users registered",
                value: "20",
                image: AppImages.personGif,
              ),
              AppStyles.sbWidth28,
              buildDashboardContainer(
                heading: "Total number of cleaner registered",
                value: "20",
                image: AppImages.cleanerGif,
              ),

              /*AppStyles.sbWidth10,
              buildDashboardContainer(
                  "Total number of bookings", "20", AppImages.personGif),
              AppStyles.sbWidth10,
              buildDashboardContainer("Total Revenue", "20", AppImages.personGif),*/
            ],
          ),
          AppStyles.sbHeight30,
          Row(
            children: [
              buildDashboardContainer(
                  heading: "Total number of bookings",
                  value: "20",
                  image: AppImages.bookingGif),
              AppStyles.sbWidth28,
              buildDashboardContainer(
                  heading: "Total Revenue",
                  value: "\$20.00",
                  image: AppImages.revenueGif,
                  color: AppColors.priceGreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDashboardContainer(
      {required String heading,
      required String value,
      required Widget image,
      Color color = AppColors.dashboardText}) {
    return Container(
      padding: AppStyles.pd30,
      height: 239,
      width: 519,
      decoration: BoxDecoration(
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
              ClipRRect(
                // borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 109,
                  width: 109,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: image,
                ),
              ),
              PoppinsSemiBoldSecond600(
                text: value,
                fontSize: 50,
                color: color,
              )
            ],
          ),
        ],
      ),
    );
  }
}
