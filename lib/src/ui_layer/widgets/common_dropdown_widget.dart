import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';

import '../../data_layer/res/colors.dart';

class CommonDropdownWidget extends StatefulWidget {
  const CommonDropdownWidget({
    Key? key,
    required this.headerText,
    required this.hintText,
    required this.dropDownItems,
    required this.selectDetail,
  }) : super(key: key);

  final String headerText;
  final String hintText;
  final List<String> dropDownItems;
  final void Function(String) selectDetail;

  @override
  State<CommonDropdownWidget> createState() => _CommonDropdownWidgetState();
}

class _CommonDropdownWidgetState extends State<CommonDropdownWidget> {
  bool _dropdownOpened = false;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          _dropDownButtonClosed(context),
          if (_dropdownOpened) _dropDownOpenedView(),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return CommonText(
      text: widget.headerText,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: AppColors.blackColor,
    );
  }

  Widget _dropDownButtonClosed(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _dropdownOpened = !_dropdownOpened;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          /*boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CommonText(
                text: selectedValue ?? "Select",
                fontWeight: FontWeight.normal,
                fontSize: AppStyles.getFontSize(16),
                color: selectedValue != null
                    ? AppColors.blackColor
                    : AppColors.lightGray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 24,
                width: 24,
                child: _dropdownOpened
                    ? AppIcons.arrowUpDropdown
                    : AppIcons.arrowDownDropdown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownOpenedView() {
    double height = widget.dropDownItems.length * 30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemCount: widget.dropDownItems.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return AppStyles.sbHeight2;
          },
          itemBuilder: (context, index) {
            return _dropDownListItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _dropDownListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValue = widget.dropDownItems[index];
          _dropdownOpened = false;
          widget.selectDetail(selectedValue!);
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          widget.dropDownItems[index],
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: AppStyles.getFontSize(16),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
