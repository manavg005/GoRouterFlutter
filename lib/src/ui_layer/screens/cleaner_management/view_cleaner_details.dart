import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/image_widget.dart';

import '../../widgets/base_widget.dart';

class CleanerDetailsScreen extends StatefulWidget {
  const CleanerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CleanerDetailsScreen> createState() => _CleanerDetailsScreenState();
}

class _CleanerDetailsScreenState extends State<CleanerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    const PoppinsLight400(text: "Dashboard", fontSize: 12),
                    AppIcons.arrowRight,
                    const PoppinsLight400(
                      text: "Cleaner Management",
                      fontSize: 12,
                    ),
                    AppIcons.arrowRight,
                    const PoppinsLight400(text: "Cleaner Name", fontSize: 12),
                  ],
                ),
              ],
            ),
            const PoppinsNormal500(
              text: "View User",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            detailContainer(),
            AppStyles.sbHeight20,
            Align(
              alignment: Alignment.centerRight,
              child: _blockButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _blockButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: AppColors.buttonLightRed, width: 1.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0), // Adjust the radius as needed
          ),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColors.buttonBackgroundRed),
      ),
      child: Text(
        "Block",
        style: TextStyle(color: AppColors.buttonTextRed),
      ),
    );
  }

  Widget detailContainer() {
    return Container(
      // height: 50,
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: SizedBox(
                height: 164,
                width: 164,
                child: CommonNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  errorIcon: Icons.person,
                  errorIconColor: Colors.red,
                  showRetryButton: false,
                )
                //     : const Icon(
                //   Icons.person,
                //   color: Colors.black,
                //   size: 40,
                // ),
                ),
          ),
          AppStyles.sbWidth10,
          Expanded(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                  ],
                ),
                AppStyles.sbHeight25,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                    Expanded(
                      child: CommonTwoColumnText(
                        headingText: "Cleaner Name",
                        subText: "Christine Wallace",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
