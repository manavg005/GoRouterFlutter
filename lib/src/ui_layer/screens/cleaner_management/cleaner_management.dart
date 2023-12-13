import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/cleaner_management/cleaner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/cleaner_management_response_model.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_alerts.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../../business_layer/helpers/date_time_helper.dart';
import '../../../business_layer/helpers/enums.dart';
import '../../widgets/base_widget.dart';
import '../../widgets/common_switch.dart';

class CleanerManagementScreen extends StatefulWidget {
  const CleanerManagementScreen({Key? key}) : super(key: key);

  @override
  State<CleanerManagementScreen> createState() =>
      _CleanerManagementScreenState();
}

class _CleanerManagementScreenState extends State<CleanerManagementScreen> {
  CleanerManagementBloc _bloc = CleanerManagementBloc();
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    _bloc.add(CleanerManagementInitialEvent());
    super.initState();
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: BlocBuilder<CleanerManagementBloc, CleanerManagementState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CleanerManagementLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CleanerManagementSuccessState) {
            return _buildBody(context, state.cleanerManagementResponseModel,
                state.currentPage);
          } else if (state is CleanerManagementErrorState) {
            AlertHelper.showToast(state.errorMessage);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      CleanerManagementResponseModel cleanerManagementResponseModel,
      int currentPage) {
    int totalPages = 0;

    if (cleanerManagementResponseModel.data != null &&
        cleanerManagementResponseModel.data!.userData != null &&
        cleanerManagementResponseModel.data!.userData!.totalCount != null) {
      int totalItems =
          cleanerManagementResponseModel.data!.userData!.totalCount!;
      int itemsPerPage = 10;
      totalPages = (totalItems / itemsPerPage).ceil();
    }
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
                    child: SearchTextField(
                  controller: _searchController,
                  hint: "Search by Name",
                  prefixIcon: AppIcons.searchIcon,
                  onChanged: (query) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();

                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      currentPage = 1;
                      _bloc.add(CleanerManagementSearchEvent(
                          _searchController.text, currentPage));
                    });
                  },
                ))
              ],
            ),
            PoppinsNormal500(
              text: "Cleaner Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(cleanerManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    int previousPage = currentPage - 1;
                    return _bloc.add(CleanerManagementSearchEvent(
                        _searchController.text, previousPage));
                  },
                  isButtonEnabled: currentPage > 1,
                ),
                // IconButton(
                //   onPressed: () {
                //     int previousPage = currentPage - 1;
                //     if (currentPage > 1) {
                //       // if (_searchController.text.isEmpty) {
                //       //   return _bloc.add(CleanerManagementLoadPreviousEvent());
                //       // } else {
                //       return _bloc.add(CleanerManagementSearchEvent(
                //           _searchController.text, previousPage));
                //       // }
                //     }
                //     // (currentPage > 1)
                //     //     ? _searchController.text.isEmpty:_userManagementBloc.add(
                //     //         UserManagementLoadPreviousEvent(),
                //     //       ):_userManagementBloc.add(UserManagementSearchEvent(
                //     //     _searchController.text, currentPage);
                //     // : SizedBox();
                //     // setState(() {});
                //   },
                //   icon: Icon(
                //     Icons.arrow_back,
                //     color: (currentPage > 1) ? Colors.black : Colors.grey,
                //   ),
                //   isSelected: (currentPage > 1),
                // ),
                CommonIconButton(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    int nextPage = currentPage + 1;
                    return _bloc.add(CleanerManagementSearchEvent(
                        _searchController.text, nextPage));
                  },
                  isButtonEnabled: (currentPage < totalPages),
                ),
              ],
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
      CleanerManagementResponseModel cleanerManagementResponseModel,
      int currentPage) {
    List<DataRow> dataRow = [];
    List<ModifiedData>? data =
        cleanerManagementResponseModel.data?.userData?.modifiedData;
    for (int i = 0; i < data!.length; i++) {
      int itemCount = (currentPage - 1) * 10 + i + 1;
      DateTime dt = DateTime.parse(data[i].createdAt ?? "");
      DataRow dataRowObject = DataRow(cells: [
        DataCell(Text("$itemCount")),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(child: Image.asset("assets/images/app_logo.png")),
            Text("${data[i].fullName}"),
          ],
        )),
        DataCell(Text("${data[i].email}")),
        DataCell(Text("${data[i].countryCode} ${data[i].phoneNumber}")),
        DataCell(Text(DateTimeHelper.getCustomDateFormat(dt))),
        DataCell(CommonSwitch(
          value: data[i].status == 2 ? true : false,
          id: data[i].sId ?? "",
          screenType: CommonSwitchScreen.cleaner,
          bloc: _bloc,
        )),
      ]);
      dataRow.add(dataRowObject);
    }
    return dataRow;
  }
}
