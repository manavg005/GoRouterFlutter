import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/helper/cookies_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';

import '../../data_layer/res/colors.dart';
import '../../data_layer/res/icons.dart';
import '../../data_layer/res/styles.dart';
import 'app_text.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Row(
        children: [
          AppIcons.profileCircle,
          AppStyles.sbWidth10,
          const PoppinsNormal500(
            text: "Alan Walker",
            fontSize: 12,
          ),
          AppStyles.sbWidth10,
          AppIcons.arrowDown,
          AppStyles.sbWidth32,
        ],
      ),
      onSelected: (String value) {
        if (value == 'profile') {
          // Handle profile action
        } else if (value == 'logout') {
          context.go('/login');
        } else if (value == 'change') {
          context.go('/dashboard/change-password');
        }
      },
      offset: Offset(-20, 60),
      elevation: 5,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(width: 16),
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
        ),
        PopupMenuItem<String>(
          // value: 'change',
          onTap: () {
            UserStateHiveHelper.instance.setIsUserLoggedIn(false);
            context.go("/login");
            CookieManager.addToCookie("drawerIndex", "0");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.blueLightShadeColor,
                  border: Border.all(color: Colors.black),
                ),
                child: PoppinsNormal500(text: "Change Password", fontSize: 12),
              ),
              SizedBox(width: 10), // Adjust as needed
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: PoppinsNormal500(
                  text: "Logout",
                  fontSize: 12,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
