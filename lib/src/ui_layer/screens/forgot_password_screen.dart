import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';

import '../../business_layer/helpers/device_info_helper.dart';
import '../../business_layer/utils/helper/validator.dart';
import '../../data_layer/res/colors.dart';
import '../../data_layer/res/icons.dart';
import '../../data_layer/res/numbers.dart';
import '../../data_layer/res/regex.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool passwordVisible = true;
  TextEditingController _emailController = TextEditingController();
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: textfieldContainer(),
        ),
        Expanded(
          flex: 3,
          child: imageContainer(),
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
          PoppinsSemiBold600(
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

  Widget imageContainer() {
    return Container(
      color: Colors.green,
      child: Image.asset(
        'images/welcome.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _continueButton() {
    return AnimatedButton(
      onPressed: () {
        print("Button clicked");
      },
      title: "CONTINUE",
      width: DeviceInfo.width,
      height: AppStyles.getHeight(58),
      // loading: _loginSignupProvider.isLoading,
      buttonColor: AppColors.mainColor,
      titleTextStyle: TextStyle(
        color: AppColors.fadeWhite,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }
}
