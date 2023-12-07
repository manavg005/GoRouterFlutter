import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';

import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../../business_layer/helpers/date_time_helper.dart';
import '../../../data_layer/res/colors.dart';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  State<PaymentManagementScreen> createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String selectedPeriod = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topNavigationROute(),
            AppStyles.sbHeight25,
            const PoppinsNormal500(
              text: "Payment Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            searchTextFields(),
            AppStyles.sbWidth10,
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchTextFields() {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            controller: _startDateController,
            hint: "Start Date",
            suffixIcon: AppIcons.calenderIcon,
            onSuffixTap: () {
              _calendar(true);
            },
          ),
        ),
        AppStyles.sbWidth24,
        const CommonText(
          text: "to",
          fontSize: 14,
        ),
        AppStyles.sbWidth24,
        Expanded(
          child: CommonTextField(
            controller: _endDateController,
            hint: "End Date",
            suffixIcon: AppIcons.calenderIcon,
            onSuffixTap: () {
              _calendar(true);
            },
          ),
        ),
        AppStyles.sbWidth24,
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightGray,
              ),
              borderRadius: BorderRadius.circular(10.0), // Adjust as needed
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(20),
                value: selectedPeriod,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPeriod = newValue!;
                  });
                },
                items: <String>['Monthly', 'Yearly'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppStyles.subtitleStyle(
                          color: AppColors.textColor, fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        /*Expanded(
          child: CommonTextField(
            controller: _dateController,
            hint: "Monthly",
            suffixIcon: AppIcons.arrowDown,
          ),
        ),*/
        AppStyles.sbWidth24,
        Expanded(
          child: SearchTextField(
              controller: _dateController, hint: "Search by Name"),
        ),
      ],
    );
  }

  /// Calendar drop down
  Future<void> _calendar(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      context: context,
    );
    if (picked != null) {
      if (isStartDate) {
        _startDateController.text = DateTimeHelper.getCustomDateFormat(picked);
        log("${_startDateController.text}");
      } else {
        _endDateController.text = DateTimeHelper.getCustomDateFormat(picked);
      }
    }
  }

  Widget topNavigationROute() {
    return Row(
      children: [
        PoppinsLight400(text: "Dashboard", fontSize: 12),
        AppIcons.arrowRight,
        PoppinsLight400(text: "Payment Management", fontSize: 12),
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('S.No.')),
      const DataColumn(label: Text('Transaction No.')),
      const DataColumn(label: Text('Date')),
      const DataColumn(label: Text('Time')),
      const DataColumn(label: Text('Booking Id')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('User Name')),
    ];
  }

  List<DataRow> _createRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < 10; i++) {
      dataRow.add(DataRow(cells: [
        DataCell(Text("1")),
        DataCell(Text("ABC12334")),
        DataCell(Text("22-10-2023")),
        DataCell(Text("12:00")),
        DataCell(Text("123454532")),
        DataCell(Text("200")),
        DataCell(Text("test")),
      ]));
    }
    return dataRow;
  }
}
