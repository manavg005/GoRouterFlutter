import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/login_bloc/login_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/change_password_request_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/route_names.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';

import '../../../business_layer/utils/helper/validator.dart';
import '../../../data_layer/res/icons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final LoginBloc _bloc = LoginBloc();
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: _buildBody(),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Padding _buildBody() {
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
                    InkWell(
                        onTap: () => context.goNamed(RouteNames.dashboard),
                        child: const PoppinsLight400(
                            text: "Dashboard", fontSize: 12)),
                    AppIcons.arrowRight,
                    const PoppinsLight400(
                        text: "Change Password", fontSize: 12),
                  ],
                ),
                AppStyles.sbWidth32,
              ],
            ),
            AppStyles.sbHeight20,
            const PoppinsNormal500(
              text: "Change Password",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            _changePasswordContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _changePasswordContainer(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 19),
        // height: 522,
        width: 400,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.containerGray,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            CommonTextField(
              controller: _currentPassword,
              hint: "Current Password",
              icon: AppIcons.passwordIcon,
              labelText: "Current Password",
              validator: ValidatorHelper.validateCurrentPassword,
              obscureText: !_isCurrentPasswordVisible,
              filled: true,
              fillColor: AppColors.whiteColor,
              suffixIcon: _isCurrentPasswordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: AppColors.textFieldHintTextColor,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: AppColors.textFieldHintTextColor,
                    ),
              onSuffixTap: () {
                setState(() {
                  _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                });
              },
            ),
            AppStyles.sbHeight20,
            CommonTextField(
              controller: _newPassword,
              hint: "New Password",
              icon: AppIcons.passwordIcon,
              labelText: "New Password",
              validator: ValidatorHelper.strongPasswordValidation,
              obscureText: !_isNewPasswordVisible,
              filled: true,
              fillColor: AppColors.whiteColor,
              suffixIcon: _isNewPasswordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: AppColors.textFieldHintTextColor,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: AppColors.textFieldHintTextColor,
                    ),
              onSuffixTap: () {
                setState(() {
                  _isNewPasswordVisible = !_isNewPasswordVisible;
                });
              },
            ),
            AppStyles.sbHeight20,
            CommonTextField(
              controller: _confirmPassword,
              hint: "Confirm Password",
              icon: AppIcons.passwordIcon,
              labelText: "Confirm Password",
              validator: (value) {
                return _confirmPasswordValidator(value);
              },
              obscureText: !_isConfirmPasswordVisible,
              filled: true,
              fillColor: AppColors.whiteColor,
              suffixIcon: _isConfirmPasswordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: AppColors.textFieldHintTextColor,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: AppColors.textFieldHintTextColor,
                    ),
              onSuffixTap: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            AppStyles.sbHeight34,
            const PoppinsLight400(
              text:
                  "* Password should contain min. 8 letter, uses uppercase and lowercase letters, numbers and special symbols.",
              fontSize: 12,
              color: Colors.grey,
            ),
            AppStyles.sbHeight30,
            _saveButton(),
            AppStyles.sbHeight19,
            InkWell(
                onTap: () {},
                child: const PoppinsNormal500(
                  text: "Cancel",
                  fontSize: 14,
                  textDecoration: TextDecoration.underline,
                ))
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _bloc,
      builder: (context, state) {
        return AnimatedButton(
          loading: state is LoginLoadingState ? true : false,
          width: double.infinity,
          buttonColor: AppColors.mainColor,
          title: "SAVE",
          titleTextStyle: const TextStyle(
            color: AppColors.fadeWhite,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          onPressed: () {
            _bloc.add(ChangePasswordClickedEvent(
                changePasswordRequestModel: _changePasswordRequestModel));
          },
        );
      },
      listener: (context, state) {
        if (state is ChangePasswordActionState) {
          context.goNamed("dashboard");
        }
      },
    );
  }

  /// Confirm password Validator
  String? _confirmPasswordValidator(String? value) {
    if (value!.isNotEmpty) {
      if (!(value.compareTo(_newPassword.text) == 0)) {
        return "Password and confirm password doesn't match.";
      }

      return null;
    }
    return "Please enter a password";
  }

  ChangePasswordRequestModel get _changePasswordRequestModel =>
      ChangePasswordRequestModel(
        confirmPassword: _confirmPassword.text,
        newPassword: _newPassword.text,
        currentPassword: _currentPassword.text,
      );
}
