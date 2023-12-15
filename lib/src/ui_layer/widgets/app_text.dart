import 'package:flutter/material.dart';
import '../../data_layer/res/colors.dart';
import '../../data_layer/res/numbers.dart';
import '../../data_layer/res/styles.dart';

/// Widget used to display common text
class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      this.color = AppColors.blackColor,
      this.fontSize = d_30,
      this.lineHeight = 0,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.w600,
      this.textDecoration = TextDecoration.none})
      : super(key: key);
  final String text;
  final Color color;
  final double fontSize;
  final double lineHeight;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        height: lineHeight,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
      textAlign: textAlign,
    );
  }
}

class CommonText2 extends StatelessWidget {
  const CommonText2(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.start,
      this.height = 0,
      this.color = Colors.black,
      this.overflow,
      this.textDecoration = TextDecoration.none,
      this.fontSize = d_45,
      this.maxLines,
      this.minFontSize,
      this.fontWeight = FontWeight.w500})
      : super(key: key);
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  final int? maxLines;
  final double? minFontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          height: height,
          decoration: textDecoration,
          fontWeight: fontWeight),
    );
  }
}

class PoppinsLight300 extends StatelessWidget {
  const PoppinsLight300({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.black,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    required this.fontSize,
    this.maxLines,
  }) : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w300,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class PoppinsLight400 extends StatelessWidget {
  const PoppinsLight400({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.black,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    required this.fontSize,
    this.maxLines,
  }) : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w400,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class PoppinsNormal500 extends StatelessWidget {
  const PoppinsNormal500({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.black,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    required this.fontSize,
    this.maxLines,
  }) : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w500,
        // height: height,
        decoration: textDecoration,
      ),
    );
  }
}

///fontWeight = 600
class PoppinsSemiBold600 extends StatelessWidget {
  const PoppinsSemiBold600(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.start,
      this.height = d_1,
      this.color = Colors.black,
      this.overflow,
      this.textDecoration = TextDecoration.none,
      required this.fontSize,
      this.maxLines,
      this.minFontSize})
      : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  final double? minFontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),

        ///fontFamily: FontFamily.fontFamilyPoppins,
        fontWeight: FontWeight.w600,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class PoppinsSemiBoldSecond600 extends StatelessWidget {
  const PoppinsSemiBoldSecond600({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.white,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    required this.fontSize,
    this.maxLines,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w600,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class PoppinsBold800 extends StatelessWidget {
  const PoppinsBold800({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.white,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    this.maxLines,
  }) : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w800,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class PoppinsExtraBold900 extends StatelessWidget {
  const PoppinsExtraBold900({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.height = d_1,
    this.color = Colors.white,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    required this.fontSize,
    this.maxLines,
  }) : super(key: key);
  final int? maxLines;
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final double height;
  final Color color;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: AppStyles.getFontSize(fontSize),
        fontWeight: FontWeight.w900,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class CommonRichTextDouble extends StatelessWidget {
  const CommonRichTextDouble({
    super.key,
    this.text1,
    this.text2,
    this.style1,
    this.style2,
  });

  final String? text1;
  final String? text2;
  final TextStyle? style1;
  final TextStyle? style2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1 ?? "",
        style: style1,
        children: [
          TextSpan(
            text: text2 ?? "",
            style: style2,
          ),
        ],
      ),
    );
  }
}

class CommonTwoColumnText extends StatelessWidget {
  const CommonTwoColumnText({
    super.key,
    required this.headingText,
    required this.subText,
    this.subColor = Colors.black,
  });

  final String headingText;
  final String subText;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PoppinsNormal500(
          text: headingText,
          fontSize: 10,
          height: 1,
          color: AppColors.titleAlertDialogColor,
        ),
        PoppinsSemiBold600(
          text: subText,
          fontSize: 13,
          height: 1.5,
          color: subColor,
        )
      ],
    );
  }
}
