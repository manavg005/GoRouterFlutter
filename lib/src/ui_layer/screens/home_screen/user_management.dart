// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/user_management/user_management_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/csv_export_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/date_time_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/user_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_switch.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final UserManagementBloc _userManagementBloc = UserManagementBloc();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _userManagementBloc.add(UserManagementInitialEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: BlocBuilder<UserManagementBloc, UserManagementState>(
        bloc: _userManagementBloc,
        builder: (context, state) {
          if (state is UserManagementLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserManagementSuccessState) {
            return _buildBody(
                context, state.userManagementResponseModel, state.currentPage);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      UserManagementResponseModel userManagementResponseModel,
      int currentPage) {
    /// pagination
    int totalPages = 0;

    if (userManagementResponseModel.data != null &&
        userManagementResponseModel.data!.userData != null &&
        userManagementResponseModel.data!.userData!.totalCount != null) {
      int totalItems = userManagementResponseModel.data!.userData!.totalCount!;
      int itemsPerPage = 10;
      totalPages = (totalItems / itemsPerPage).ceil();
    }
    return Padding(
      padding: const EdgeInsets.all(26.0),
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
                        text: "User Management", fontSize: 12),
                  ],
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      List<ModifiedData>? data = userManagementResponseModel
                          .data?.userData?.modifiedData;
                      List<List<dynamic>> exportData = [
                        [
                          'S.No.',
                          'Profile Name',
                          'Email',
                          'Mobile No.',
                          'Date Registered',
                          'Action'
                        ],
                        for (int i = 0; i < data!.length; i++)
                          [
                            i + 1,
                            data[i].fullName,
                            data[i].email,
                            '${data[i].countryCode} ${data[i].phoneNumber}',
                            DateTimeHelper.getCustomDateFormat(
                                DateTime.parse(data[i].createdAt ?? "")),
                            data[i].status == 2 ? 'Active' : 'Inactive',
                          ],
                      ];

                      CsvHelper.exportToCSV(exportData, 'user_management_data');
                    },
                    child: AppIcons.downloadIcon),
                const CommonText(
                  text: "Download",
                  color: AppColors.iconBlue,
                  fontSize: 14,
                ),
                AppStyles.sbWidth32,
                Expanded(
                    child: SearchTextField(
                  controller: _searchController,
                  hint: "Search by Name",
                  prefixIcon: AppIcons.searchIcon,
                  onChanged: (query) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();

                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      currentPage = 1;
                      // _userManagementBloc.add(UserManagementInitialEvent(
                      //     searchQuery: _searchController.text,
                      //     page: currentPage));
                      _userManagementBloc.add(UserManagementSearchEvent(
                          _searchController.text, currentPage));
                    });
                  },
                ))
              ],
            ),
            const PoppinsNormal500(
              text: "User Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(userManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    int previousPage = currentPage - 1;
                    return _userManagementBloc.add(UserManagementSearchEvent(
                        _searchController.text, previousPage));
                  },
                  isButtonEnabled: currentPage > 1,
                ),
                CommonIconButton(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    int nextPage = currentPage + 1;

                    if (nextPage <= totalPages) {
                      return _userManagementBloc.add(UserManagementSearchEvent(
                          _searchController.text, nextPage));
                    }
                  },
                  isButtonEnabled: (currentPage < totalPages),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* /// when search item is changed
  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      currentPage = 1;
      _userManagementBloc
          .add(UserManagementSearchEvent(_searchController.text, currentPage));
    });
  }*/

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: PoppinsNormal500(text: 'S.No.', fontSize: 12)),
      const DataColumn(
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

  List<DataRow> _createRows(
      UserManagementResponseModel userManagementResponseModel,
      int currentPage) {
    List<DataRow> dataRow = [];
    List<ModifiedData>? data =
        userManagementResponseModel.data?.userData?.modifiedData;

    for (int i = 0; i < data!.length; i++) {
      int itemCount = (currentPage - 1) * 10 + i + 1;
      DateTime dt = DateTime.parse(data[i].createdAt ?? "");
      DataRow dataRowObject = DataRow(cells: [
        DataCell(Text("$itemCount")),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(child: AppIcons.profileCircle),
            Text("${data[i].fullName}"),
          ],
        )),
        DataCell(Text("${data[i].email}")),
        DataCell(Text("${data[i].countryCode} ${data[i].phoneNumber}")),
        DataCell(Text(DateTimeHelper.getCustomDateFormat(dt))),
        DataCell(CommonSwitch(
          value: data[i].status == 2 ? true : false,
          id: data[i].sId ?? "",
          screenType: CommonSwitchScreen.user,
          bloc: _userManagementBloc,
        )),
      ]);
      dataRow.add(dataRowObject);
    }
    return dataRow;
  }
}
