import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';

import '../../business_layer/helpers/enums.dart';
import '../../data_layer/models/response/booking_management_response.dart';
import '../../data_layer/res/colors.dart';

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.blueLightShadeColor,
      insetPadding: const EdgeInsets.only(left: 1000, bottom: 400),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 86,
                  width: 86,
                  color: Colors.grey,
                  child: AppIcons.profileCircle,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PoppinsNormal500(
                    text: "Alen Walker",
                    fontSize: 18,
                    height: 2,
                  ),
                  PoppinsLight400(
                    text: "alen@yopmail.com",
                    fontSize: 12,
                    height: 2,
                  ),
                  PoppinsLight400(
                    text: "+91 908348384",
                    fontSize: 12,
                    height: 2,
                  ),
                ],
              ),
            ],
          ),
          AppStyles.sbHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  context.go('/dashboard/change-password');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.blueLightShadeColor,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const PoppinsNormal500(
                      text: "Change Password", fontSize: 12),
                ),
              ),
              AppStyles.sbWidth16,
              GestureDetector(
                onTap: () {
                  context.go('/login');
                  Navigator.pop(context);
                  // Add logic for "Change Password" button
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const PoppinsNormal500(
                    text: "Logout",
                    fontSize: 12,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDetailsDialog extends StatelessWidget {
  const CustomDetailsDialog({
    Key? key,
    required this.bookingType,
    required this.progressStatus,
    required this.id,
    required this.details,
  }) : super(key: key);
  final MyBookingTab bookingType;
  final BookingProgressStatus progressStatus;
  final String id;
  final ModifiedData details;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: LinearBorder.start(),
      backgroundColor: Colors.white,
      content: Builder(
        builder: (context) {
          // var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          Color statusColor = (details.status == '0')
              ? AppColors.newBookingTextColor
              : (details.status == '1')
                  ? AppColors.greenShadeColor
                  : (details.status == '3' || details.status == '4')
                      ? AppColors.bookingCancelledRed
                      : AppColors.mainColor;
          String statusText = (details.status == '0')
              ? "Action Pending By cleaner"
              : (details.status == '1')
                  ? "Accepted"
                  : (details.status == '3')
                      ? "Completed"
                      : (details.status == '4')
                          ? "Cancelled"
                          : "2";

          return SingleChildScrollView(
            child: SizedBox(
              width: width - 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const PoppinsNormal500(
                        text: "Booking Details",
                        fontSize: 20,
                      ),
                      const Spacer(),
                      PoppinsSemiBold600(
                        text:
                            "Booking ID: ${(details.sId!.substring(details.sId!.length - 10)).toUpperCase()}",
                        fontSize: 12,
                        color: AppColors.bookingIdGreen,
                      ),
                      AppStyles.sbWidth32,
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: AppIcons.crossIcon,
                      )
                    ],
                  ),
                  AppStyles.sbHeight15,
                  CommonRichTextDouble(
                    text1: "Status: ",
                    text2: statusText,
                    style1: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    style2: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppStyles.sbHeight21,
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.iconBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 59,
                            child: AppImages.welcomeImage,
                          ),
                        ),
                        AppStyles.sbWidth5,
                        Expanded(
                          child: CommonTwoColumnText(
                            headingText: "Customer Name",
                            subText: details.customer ?? "",
                            subColor: AppColors.whiteColor,
                          ),
                        ),
                        Expanded(
                          child: CommonTwoColumnText(
                            headingText: "Email",
                            subText: details.email ?? "",
                            subColor: AppColors.whiteColor,
                          ),
                        ),
                        Expanded(
                          child: CommonTwoColumnText(
                            headingText: "Phone Number",
                            subText: details.phoneNumber ?? "",
                            subColor: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppStyles.sbHeight21,
                  const Divider(),
                  const PoppinsNormal500(
                    text: "Address",
                    fontSize: 16,
                    height: 24,
                  ),
                  AppStyles.sbHeight15,
                  CommonTwoColumnText(
                    headingText: "Street Address",
                    subText:
                        "${details.serviceAddress?.addressLine1} ${details.serviceAddress?.addressLine2} ",
                  ),
                  AppStyles.sbHeight14,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonTwoColumnText(
                          headingText: "Unit", subText: "--"),
                      CommonTwoColumnText(
                          headingText: "City",
                          subText: details.serviceAddress!.city ?? ""),
                      CommonTwoColumnText(
                          headingText: "Postal Code",
                          subText: details.serviceAddress!.zipCode ?? ""),
                      CommonTwoColumnText(
                          headingText: "Province",
                          subText: details.serviceAddress!.state ?? ""),
                    ],
                  ),
                  const Divider(),
                  const PoppinsNormal500(
                    text: "Property Details",
                    fontSize: 16,
                    height: 24,
                  ),
                  AppStyles.sbHeight15,
                  CommonTwoColumnText(
                    headingText: "Property Type",
                    subText: details.propertyType!.name ?? "",
                  ),
                  AppStyles.sbHeight14,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTwoColumnText(
                          headingText: "Floor",
                          subText: "${details.noOfFloor}"),
                      CommonTwoColumnText(
                          headingText: "Bedroom",
                          subText: details.bedrooms!.name!.split(" ")[0]),
                      CommonTwoColumnText(
                          headingText: "Bathroom",
                          subText: details.bathroom!.name!.split(" ")[0]),
                      CommonTwoColumnText(
                          headingText: "Total Area in sq feet.",
                          subText:
                              details.totalSquareFeet!.name!.split(" ")[0]),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTwoColumnText(
                                headingText:
                                    "When was your last full cleaning?",
                                subText: details.lastCleaning!.name!),
                            CommonTwoColumnText(
                                headingText: "Do you have any pets?",
                                subText: details.pets!.name!),
                            CommonTwoColumnText(
                                headingText: "How often you want us to clean ",
                                subText: details.oftenUsed!.name!),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTwoColumnText(
                                headingText: "Cleaner Name",
                                subText: details.cleaner!),
                            CommonTwoColumnText(
                                headingText: "Total Charges",
                                subText: '\$ ${details.amount}'),
                            const PoppinsNormal500(
                              text: "Payment Status",
                              fontSize: 10,
                              height: 1,
                              color: AppColors.titleAlertDialogColor,
                            ),
                            Container(
                              decoration: AppStyles.appButtonBoxDecoration(
                                  AppColors.paymentDoneGreen,
                                  radius: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 68.0, vertical: 4.0),
                              child: const PoppinsSemiBold600(
                                text: "DONE",
                                fontSize: 13,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
