import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../widgets/base_widget.dart';

class CleanerManagementScreen extends StatefulWidget {
  const CleanerManagementScreen({Key? key}) : super(key: key);

  @override
  State<CleanerManagementScreen> createState() =>
      _CleanerManagementScreenState();
}

class _CleanerManagementScreenState extends State<CleanerManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;

  void toggleSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: _buildBody(),
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
                    PoppinsLight400(text: "Dashboard", fontSize: 12),
                    AppIcons.arrowRight,
                    PoppinsLight400(text: "Cleaner Management", fontSize: 12),
                  ],
                ),
                Spacer(),
                InkWell(onTap: () {}, child: AppIcons.downloadIcon),
                CommonText(
                  text: "Download",
                  color: AppColors.iconBlue,
                  fontSize: 14,
                ),
                AppStyles.sbWidth32,
                Expanded(
                  child: CommonTextField(
                    controller: _searchController,
                    hint: "Search by Name",
                    prefixIcon: AppIcons.searchIcon,
                  ),
                ),
              ],
            ),
            PoppinsNormal500(
              text: "Cleaner Management",
              fontSize: 20,
            ),
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

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: PoppinsNormal500(text: 'S.No.', fontSize: 12)),
      DataColumn(
          label: PoppinsNormal500(
              text: 'Profile Name.',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(label: PoppinsNormal500(text: 'Email', fontSize: 12)),
      const DataColumn(
          label: PoppinsNormal500(text: 'Mobile No.', fontSize: 12)),
      const DataColumn(
          label: PoppinsNormal500(
        text: 'Date Registered',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      )),
      const DataColumn(label: PoppinsNormal500(text: 'Action', fontSize: 12)),
    ];
  }

  List<DataRow> _createRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < 10; i++) {
      dataRow.add(DataRow(cells: [
        DataCell(Text("1")),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(child: Image.asset("assets/images/app_logo.png")),
            Text("ABC"),
          ],
        )),
        DataCell(Text("AVC@yopmail.com")),
        DataCell(Text("123454532")),
        DataCell(Text("22-10-2023")),
        DataCell(
          CupertinoSwitch(
            value: isSelected, // Use the isSelected variable here
            onChanged: toggleSwitch,
            activeColor: AppColors.themeGreenColor,
          ),
        ),
      ]));
    }
    return dataRow;
  }
}
