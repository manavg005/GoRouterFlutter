import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/login_bloc/login_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/login_info.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/route_names.dart';
import '../../data_layer/local_db/user_state_hive_helper.dart';
import '../../data_layer/res/colors.dart';
import '../../data_layer/res/icons.dart';
import '../../data_layer/res/numbers.dart';
import '../../data_layer/res/styles.dart';
import 'app_buttons.dart';
import 'app_text.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommonAppBar({super.key, this.title, this.size});
  String? title;
  double? size;
  // VoidCallback? onBackArrow;
  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CommonAppBarState extends State<CommonAppBar> {
  LoginBloc _bloc = LoginBloc();
  String fullName = "";
  String email = "";
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getUserDetails();
    // String? adminName = fullName;
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: AppColors.blackColor),
      centerTitle: true,
      elevation: 10,
      backgroundColor: Colors.white,
      title: widget.title == null
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(d_20, d_20, d_0, d_0),
              child: CommonText(
                text: widget.title ?? "",
                fontSize: AppStyles.getFontSize(18),
                fontWeight: FontWeight.w500,
              ),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 28),
          child: Row(
            children: [
              AppIcons.profileCircle,
              AppStyles.sbWidth8,
              PoppinsNormal500(text: fullName, fontSize: 14),
              AppStyles.sbWidth8,
              InkWell(
                  child: AppIcons.arrowDown,
                  onTap: () {
                    print("Tap");
                    _showContainer(context, fullName, email, phoneNumber);
                  })
            ],
          ),
        ),
      ],
    );
  }

  /// admin details to show on the top of app bar
  Future<void> _getUserDetails() async {
    // print("local ==> ${window.localStorage['localKey']}");
    fullName = await UserStateHiveHelper.instance.getUserName();
    email = await UserStateHiveHelper.instance.getUserEmail();
    phoneNumber = await UserStateHiveHelper.instance.getUserPhone();
  }

  /// App bar Popup menu for admin details
  Future<void> _showContainer(BuildContext context, String adminName,
      String adminEmail, String adminPhone) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    return showMenu(
      shadowColor: Colors.transparent,
      // elevation: 20 ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.whiteColor,
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 60.0, // Right padding
        70.0, // Top padding
        overlay.size.width, // Left padding
        overlay.size.height - 10.0, // Bottom padding
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'option1',
          child: Column(
            children: [
              AppStyles.sbHeight10,
              Row(
                children: [
                  AppIcons.profileCircle,
                  AppStyles.sbWidth14,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoppinsNormal500(text: adminName, fontSize: 18),
                      AppStyles.sbHeight2,
                      PoppinsLight400(
                        text: adminEmail,
                        fontSize: 12,
                        color: AppColors.darkGray,
                      ),
                      AppStyles.sbHeight2,
                      PoppinsLight400(
                        text: adminPhone,
                        fontSize: 12,
                        color: AppColors.darkGray,
                      ),
                    ],
                  ),
                ],
              ),
              AppStyles.sbHeight17,
              const Divider(
                color: AppColors.whiteColor,
                height: 1,
              ),
              AppStyles.sbHeight17,
            ],
          ),
        ),
        PopupMenuItem<String>(
          mouseCursor: MouseCursor.uncontrolled,
          value: 'option2',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonAppButton(
                      onTap: () {
                        Navigator.pop(context);

                        GoRouter.of(context)
                            .goNamed(RouteNames.changePasswordScreen);
                      },
                      text: 'Change Password',
                      buttonColor: AppColors.whiteColor,
                      textColor: AppColors.blackColor,
                      radius: 0.0,
                      fontSize: 14,
                      borderColor: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                  // AppStyles.sbWidth12,
                  _logoutButton(context)
                ],
              ),
              AppStyles.sbHeight15,
            ],
          ),
        ),
      ],
    );
  }

  Widget _logoutButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _bloc,
      builder: (context, state) {
        return CommonAppButton(
          onTap: () {
            Navigator.pop(context);
            // GoRouter.of(context).goNamed(RouteNames.login);
            // UserStateHiveHelper.instance.setIsUserLoggedIn(false);
            // UserStateHiveHelper.instance.clearData();
            _bloc.add(LogoutButtonClickedEvent());

            // _logoutApiCall();
          },
          text: 'Logout',
          buttonColor: AppColors.blackColor,
          fontSize: 14,
          radius: 0.0,
          fontWeight: FontWeight.w500,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
        );
      },
    );
  }

  // Future<void> _logoutApiCall() async {
  //   await _loginSignupProvider.logout().then((value) {
  //     if (value == HttpResponseType.success) {
  //       GoRouter.of(context).go('/login');
  //     } else {
  //       DialogUtil.showToastMessage(value ?? "Something went wrong");
  //     }
  //   });
  // }
}
// class _CommonAppBarState extends State<CommonAppBar> {
//
//
