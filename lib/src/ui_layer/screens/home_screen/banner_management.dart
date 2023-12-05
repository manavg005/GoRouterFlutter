import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/images.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/numbers.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../widgets/base_widget.dart';

class BannerManagementScreen extends StatefulWidget {
  const BannerManagementScreen({Key? key}) : super(key: key);

  @override
  State<BannerManagementScreen> createState() => _BannerManagementScreenState();
}

class _BannerManagementScreenState extends State<BannerManagementScreen> {
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
                    const PoppinsLight400(text: "Dashboard", fontSize: 12),
                    AppIcons.arrowRight,
                    const PoppinsLight400(
                        text: "Banner Management", fontSize: 12),
                  ],
                ),
                const Spacer(),
                CommonAppButton(
                  onTap: () {},
                  text: "Add Banner",
                  fontSize: 12,
                  radius: 5,
                  textHeight: onePointTwo,
                  buttonColor: AppColors.iconBlue,
                  fontWeight: FontWeight.w500,
                ),
                AppStyles.sbWidth32,
                Expanded(
                  child: SearchTextField(
                    controller: _searchController,
                    hint: "Search by Name",
                    prefixIcon: AppIcons.searchIcon,
                  ),
                ),
              ],
            ),
            const PoppinsNormal500(
              text: "Banner Management",
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
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Banner', fontSize: 12, overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Banner Name',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(label: PoppinsNormal500(text: 'Action', fontSize: 12)),
    ];
  }

  List<DataRow> _createRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < 10; i++) {
      DataRow dataRowObject = DataRow(cells: [
        DataCell(Text("1")),
        DataCell(SizedBox(height: 27, child: AppImages.bannerImage)),
        DataCell(Text("123454532")),
        DataCell(
          CupertinoSwitch(
            value: isSelected, // Use the isSelected variable here
            onChanged: toggleSwitch,
            activeColor: AppColors.themeGreenColor,
          ),
        ),
      ]);
      dataRow.add(dataRowObject);
    }
    return dataRow;
  }
}
