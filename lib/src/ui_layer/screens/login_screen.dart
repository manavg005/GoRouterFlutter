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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _checkBoxValue = false;
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
            text: "Sign in to Admin Panel",
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
            validator: ValidatorHelper.validateEmailPhone,
            keyboardType: TextInputType.emailAddress,
          ),
          AppStyles.sbHeight20,
          CommonTextField(
            controller: _passwordController,
            hint: "Enter your password",
            inputFormatters: FilterFormatter.passwordFieldFormatter,
            icon: AppIcons.passwordIcon,
            enabled: true,
            labelText: "Password",
            obscureText: passwordVisible,
            inputBorderColor: AppColors.lightGray,
            validator: ValidatorHelper.strongPasswordValidation,
            suffixIcon: passwordVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: AppColors.textFieldHintTextColor,
                  )
                : const Icon(
                    Icons.visibility,
                    color: AppColors.textFieldHintTextColor,
                  ),
            onSuffixTap: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          AppStyles.sbHeight20,
          rememberMeForgotPassword(),
          AppStyles.sbHeight36,
          _loginButton(),
        ],
      ),
    );
  }

  Widget rememberMeForgotPassword() {
    return Row(
      children: [
        // Left side (Checkbox and "Remember Me" text)
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1,
                child: Checkbox(
                  activeColor: AppColors.mainColor,
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      width: 1,
                      color: AppColors.subHeadingBlackColor,
                    ),
                  ),
                  value: _checkBoxValue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(d_5),
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      _checkBoxValue = value!;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
              ),
              AppStyles.sbWidth1,
              Text(
                "Remember Me",
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: d_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Right side ("Forgot Password?" text)
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              context.go("/forgot-password");
              print("clicked");
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: d_12,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ),
      ],
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

  Widget _loginButton() {
    return AnimatedButton(
      onPressed: () {
        context.go("/home");
        /*if (_formKey.currentState!.validate()) {
          _loginSignupProvider.isLoading = true;

          /// check if the entered text is a phone number or an email address
          if (RegExp(r'^[0-9]*$').hasMatch(_emailController.text)) {
            /// phone number
            /// call login api
            _loginSignupProvider
                .login(modelPhone: _getLoginRequestPhone)
                .then((value) {
              _handleLoginResponse(value);
            });
          } else {
            /// email address
            /// call login api
            _loginSignupProvider
                .login(model: _getLoginRequestEmail)
                .then((value) {
              _handleLoginResponse(value);
            });
          }
        }*/
      },
      title: "Sign in",
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
