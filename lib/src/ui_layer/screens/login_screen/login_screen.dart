import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/login_bloc/login_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/device_info_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/login_info.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/helper/validator.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/login_request_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/numbers.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/regex.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _checkBoxValue = false;
  bool _isLoading = false;

  @override
  void initState() {
    // loginBloc.add(LoginInitialEvent());
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
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      // buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          _isLoading = true;
        }
        if (state is LoginNavigateToHomeActionState) {
          context.goNamed("dashboard");
        } else {
          _isLoading = false;
          log("Error");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: _loginTextFields(),
          ),
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 4,
              child: _imageContainer(),
            ),
        ],
      ),
      // switch (state.runtimeType) {
      //   case LoginLoadingState:
      //     return Scaffold(
      //       body: Center(
      //         child: CircularProgressIndicator(),
      //       ),
      //     );
      //   case LoginSuccessState:
      //     final successState = state as LoginSuccessState;
      //     return Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           flex: 3,
      //           child: _loginTextFields(),
      //         ),
      //         if (Responsive.isDesktop(context))
      //           Expanded(
      //             flex: 4,
      //             child: _imageContainer(),
      //           )
      //       ],
      //     );
      //   case LoginErrorState:
      //     return Text("Error");
      //   default:
      //     return SizedBox();
      // }
      // return Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Expanded(
      //       flex: 3,
      //       child: _loginTextFields(),
      //     ),
      //     if (Responsive.isDesktop(context))
      //       Expanded(
      //         flex: 4,
      //         child: _imageContainer(),
      //       )
      //   ],
      // );
    );
  }

  Widget _loginTextFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 115),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AppStyles.sbHeight104,
            const PoppinsSemiBold600(
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
              validator: ValidatorHelper.validateEmail,
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
              validator: (value) =>
                  ValidatorHelper.nonEmptyValidation(value, "Password"),
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
            _rememberMeForgotPassword(),
            AppStyles.sbHeight36,
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _rememberMeForgotPassword() {
    return Row(
      children: [
        Expanded(
          child: _checkBoxField(),
        ),
        forgotPasswordText(),
      ],
    );
  }

  Row _checkBoxField() {
    return Row(
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
        const Text(
          "Remember Me",
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: d_12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget forgotPasswordText() {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          context.goNamed("forgot");
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: d_12,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return Container(
      // color: Colors.green,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppImages.welcomeImage,
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: loginBloc,
        builder: (context, state) {
          // if (state is LoginLoadingState) {
          //   return const Center(child: CircularProgressIndicator());
          // } else {
          print("state==>> $state");
          return AnimatedButton(
            disabled: (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _checkBoxValue)
                ? false
                : true,
            loading: state is LoginLoadingState ? true : false,
            onPressed: () async {
              log("Logged IN Status==>>${await UserStateHiveHelper.instance.getIsUserLoggedIn()}");
              loginBloc.add(LoginButtonClickedEvent(
                  loginRequestModel: _getLoginRequestModel));
            },
            title: "Sign in",
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
        // },
        );
  }

  /// Login Request
  LoginRequestModel get _getLoginRequestModel => LoginRequestModel(
      email: "admin@yopmail.com",
      password: "@Test1234",
      // email: _emailController.text,
      // password: _passwordController.text,

      deviceToken: "abcd",
      deviceId: "abcd",
      deviceType: "abcd");
}
