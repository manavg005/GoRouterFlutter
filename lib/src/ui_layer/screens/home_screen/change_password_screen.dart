import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

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
        padding: EdgeInsets.symmetric(horizontal: 52, vertical: 19),
        height: 522,
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
                _confirmPasswordValidator(value);
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
                onTap: () => context.pushNamed(RouteNames.dashboard),
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

  AnimatedButton _saveButton() {
    return AnimatedButton(
      width: double.infinity,
      buttonColor: AppColors.mainColor,
      title: "SAVE",
      titleTextStyle: TextStyle(
        color: AppColors.fadeWhite,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
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
}
