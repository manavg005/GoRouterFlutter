import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/responsive.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';

import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/device_info_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/helper/validator.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/regex.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: body(),
      backgroundColor: Colors.white,
    );
  }

  Widget body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: textfieldContainer(),
        ),
        if (Responsive.isDesktop(context))
          Expanded(
            flex: 4,
            child: _imageContainer(),
          )
      ],
    );
  }

  Widget textfieldContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 115),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // AppStyles.sbHeight104,
          const PoppinsSemiBold600(
            text: "Forgot Password",
            fontSize: 30,
          ),
          AppStyles.sbHeight52,
          CommonTextField(
            controller: _emailController,
            hint: "Enter your Email",
            icon: AppIcons.emailIcon,
            enabled: true,
            inputFormatters: FilterFormatter.emailFilterFormatter,
            labelText: "Email",
            inputBorderColor: AppColors.lightGray,
            validator: ValidatorHelper.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          AppStyles.sbHeight55,
          _continueButton(),
        ],
      ),
    );
  }

  Widget _imageContainer() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppImages.welcomeImage,
    );
  }

  Widget _continueButton() {
    return AnimatedButton(
      onPressed: () {},
      title: "CONTINUE",
      width: DeviceInfo.width,
      height: AppStyles.getHeight(58),
      // loading: _loginSignupProvider.isLoading,
      buttonColor: AppColors.mainColor,
      titleTextStyle: const TextStyle(
        color: AppColors.fadeWhite,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }
}
