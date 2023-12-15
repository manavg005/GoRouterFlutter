import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data_layer/res/colors.dart';
import '../../data_layer/res/icons.dart';
import '../../data_layer/res/numbers.dart';
import '../../data_layer/res/styles.dart';
import 'app_text.dart';

/// Widget used to display common text field
class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.labelText,
      this.icon,
      this.validator,
      this.error = false,
      this.inputFormatters,
      this.onSubmitted,
      this.onChanged,
      this.focusNode,
      this.keyboardType,
      this.radius,
      this.name = false,
      this.obscureText = false,
      this.filled = false,
      this.textCapitalization = TextCapitalization.none,
      this.readOnly = false,
      this.maxLength,
      this.enabled = true,
      this.suffixIcon,
      this.prefixIcon,
      this.style,
      this.textInputAction,
      this.onTap,
      this.fillColor,
      this.onPrefixTap,
      this.onSuffixTap,
      this.prefixConstraints,
      this.maxLines = 1,
      this.minLines = 1,
      this.autofocus = false,
      this.toolBarOptions = true,
      this.inputBorderColor = AppColors.subHeadingBlackColor,
      this.labelTextColor = AppColors.textFieldLabelColor,
      this.hintTextSize,
      this.labelTextSize,
      this.autoValidateMode = AutovalidateMode.onUserInteraction})
      : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final bool error;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool name;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool filled;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final int? maxLength;
  final bool enabled;
  final Color inputBorderColor;
  final TextStyle? style;
  final void Function()? onTap;
  final Color? fillColor;
  final void Function()? onPrefixTap;
  final void Function()? onSuffixTap;
  final double? radius;
  final BoxConstraints? prefixConstraints;
  final int maxLines;
  final int minLines;
  final bool toolBarOptions;
  final bool autofocus;
  final Widget? icon;
  final String? labelText;
  final Color labelTextColor;
  final AutovalidateMode autoValidateMode;
  final double? hintTextSize;
  final double? labelTextSize;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labelText(),
        AppStyles.sbHeight6,
        TextFormField(
          obscureText: obscureText,
          obscuringCharacter: "•",
          enabled: enabled,
          onChanged: onChanged,
          autovalidateMode: autoValidateMode,
          maxLength: maxLength,
          onTap: onTap,
          onFieldSubmitted: onSubmitted,
          // cursorWidth: d_2,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          autofocus: autofocus,
          cursorRadius: const Radius.circular(d_5),
          controller: controller,
          scrollPhysics: const ClampingScrollPhysics(),
          style: style ??
              AppStyles.subtitleStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
              ),
          cursorColor: AppColors.headingBlackColor,
          // cursorHeight: Platform.isIOS && !DeviceInfo.extraLargeDevice ? d_15 : d_20,
          textInputAction: textInputAction ?? TextInputAction.done,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          keyboardAppearance: Brightness.light,
          textCapitalization: textCapitalization,
          readOnly: readOnly,
          decoration: InputDecoration(
            errorMaxLines: 5,
            counterText: "",
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap ?? () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: d_1,
                    icon: suffixIcon!,
                  )
                : null,
            prefixIconConstraints: prefixConstraints,
            prefixIcon: prefixIcon != null
                ? IconButton(
                    onPressed: onPrefixTap ?? () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: d_1,
                    icon: prefixIcon!,
                  )
                : null,
            hintText: hint,
            hintStyle: AppStyles.subtitleStyle(
              color: AppColors.lightGray,
              fontSize: hintTextSize != null
                  ? AppStyles.getFontSize(hintTextSize!)
                  : 12,
            ),
            filled: filled,
            fillColor: fillColor ?? AppColors.readOnlyColor,
            focusedBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            isDense: true,
            border: _inputBorder(),
            contentPadding: AppStyles.textFieldContentPadding,
          ),
          // toolbarOptions: ToolbarOptions(
          //   copy: toolBarOptions,
          //   cut: toolBarOptions,
          //   paste: toolBarOptions,
          //   selectAll: toolBarOptions,
          // ),
        ),
      ],
    );
  }

  Widget _labelText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon != null ? icon! : const SizedBox(),
        AppStyles.sbWidth3,
        CommonText(
          text: labelText ?? "",
          fontSize: labelTextSize != null
              ? AppStyles.getFontSize(labelTextSize!)
              : 14,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.end,
          color: labelTextColor,
        )
      ],
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: inputBorderColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          radius ?? d_10,
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.error = false,
    this.inputFormatters,
    this.onSubmitted,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
    this.radius,
    this.name = false,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIcon2,
    this.filled = false,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.maxLength,
    this.enabled = true,
    this.prefixIcon,
    this.style,
    this.textInputAction,
    this.onTap,
    this.fillColor,
    this.onPrefixTap,
    this.onSuffixTap,
    this.prefixConstraints,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.toolBarOptions = true,
    this.inputBorderColor = AppColors.subHeadingBlackColor,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hint;
  final bool error;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool name;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? suffixIcon2;
  final Widget? prefixIcon;
  final bool filled;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final int? maxLength;
  final bool enabled;
  final Color? inputBorderColor;
  final TextStyle? style;
  final void Function()? onTap;
  final Color? fillColor;
  final void Function()? onPrefixTap;
  final void Function()? onSuffixTap;
  final double? radius;
  final BoxConstraints? prefixConstraints;
  final int maxLines;
  final int minLines;
  final bool toolBarOptions;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppStyles.sbHeight6,
        ClipRRect(
          borderRadius: BorderRadius.circular(d_10),
          child: TextField(
            obscureText: obscureText,
            obscuringCharacter: "*",
            enabled: enabled,
            onChanged: onChanged,
            maxLength: maxLength,
            onTap: onTap,
            onSubmitted: onSubmitted,
            cursorWidth: d_2,
            maxLines: maxLines,
            minLines: minLines,
            autofocus: autofocus,
            cursorRadius: const Radius.circular(d_10),
            controller: controller,
            scrollPhysics: const ClampingScrollPhysics(),
            style: style ??
                AppStyles.subtitleStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
            cursorColor: AppColors.headingBlackColor,
            // cursorHeight: Platform.isIOS && !DeviceInfo.extraLargeDevice ? d_15 : d_20,
            textInputAction: textInputAction ?? TextInputAction.done,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            keyboardAppearance: Brightness.light,
            textCapitalization: textCapitalization,
            readOnly: readOnly,
            decoration: InputDecoration(
              counterText: "",
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onSuffixTap ?? () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: d_1,
                      icon: controller!.text.isNotEmpty
                          ? suffixIcon!
                          : AppIcons.searchIcon,
                    )
                  : null,
              prefixIconConstraints: prefixConstraints,
              prefixIcon: prefixIcon != null
                  ? IconButton(
                      onPressed: onPrefixTap ?? () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: d_1,
                      icon: prefixIcon!,
                    )
                  : null,
              hintText: hint,
              hintStyle: AppStyles.subtitleStyle(
                fontSize: AppStyles.getFontSize(12),
                color: AppColors.subHeadingBlackColor,
              ),
              filled: filled,
              fillColor: fillColor ?? AppColors.readOnlyColor,
              focusedBorder: _inputBorder(),
              enabledBorder: _inputBorder(),
              isDense: true,
              border: _inputBorder(),
              contentPadding: AppStyles.textFieldContentPadding,
            ),
            // toolbarOptions: ToolbarOptions(
            //   copy: toolBarOptions,
            //   cut: toolBarOptions,
            //   paste: toolBarOptions,
            //   selectAll: toolBarOptions,
            // ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.5,
        color: AppColors.subHeadingBlackColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          radius ?? d_10,
        ),
      ),
    );
  }
}

class CommonTextFieldWithTitle extends StatelessWidget {
  const CommonTextFieldWithTitle(
      {this.title,
      this.icon,
      this.hintText,
      required this.controller,
      this.suffixIcon,
      this.maxline = 1,
      Key? key,
      this.validation,
      this.onSuffixTap,
      this.inputFormatters,
      this.obscureText,
      this.keyboardType,
      this.maxLength,
      this.enable = true,
      this.prefixIcon,
      this.titleSize = 14,
      this.minline = 1})
      : super(key: key);

  final Widget? icon;
  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? Function(String? text)? validation;
  final void Function()? onSuffixTap;
  final List<TextInputFormatter>? inputFormatters;
  final int maxline;
  final int minline;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool enable;
  final Widget? prefixIcon;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            icon ?? const SizedBox.shrink(),
            AppStyles.sbWidth3,
            PoppinsNormal500(
              text: title ?? "",
              fontSize: titleSize,
              color: AppColors.blackColor,
            )
          ],
        ),
        AppStyles.sbHeight10,
        CommonTextField(
          labelText: "",
          controller: controller,
          hint: hintText ?? "",
          inputBorderColor: AppColors.textFieldBorder,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onSuffixTap ?? () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: d_1,
                  icon: suffixIcon!,
                )
              : null,
          maxLines: maxline,
          validator: validation,
          prefixIcon: prefixIcon,
          inputFormatters: inputFormatters,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          maxLength: maxLength,
          enabled: enable,
          filled: enable,
          fillColor: AppColors.whiteColor,
          minLines: minline,
          // fillColor: !enable ? Colors.blueGrey : Colors.white,
        )
      ],
    );
  }
}
