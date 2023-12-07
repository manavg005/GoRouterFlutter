import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/notification_management/notification_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/date_time_helper.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/notification_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../widgets/base_widget.dart';

class NotificationManagementScreen extends StatefulWidget {
  const NotificationManagementScreen({Key? key, required this.detailsPath})
      : super(key: key);

  /// The path to the detail page
  final String detailsPath;
  @override
  State<NotificationManagementScreen> createState() =>
      _NotificationManagementScreenState();
}

class _NotificationManagementScreenState
    extends State<NotificationManagementScreen> {
  final NotificationBloc _bloc = NotificationBloc();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.add(NotificationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return LinearProgressIndicator();
          } else if (state is NotificationSuccessState) {
            return _buildBody(context,
                state.notificationManagementResponseModel, state.currentPage);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Padding _buildBody(
      BuildContext context,
      NotificationManagementResponseModel notificationManagementResponseModel,
      int currentPage) {
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
                    PoppinsLight400(
                        text: "Notification Management", fontSize: 12),
                  ],
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      context
                          .go('/notification-management/send-new-notification');
                    },
                    child: AppIcons.addIcon),
                CommonText(
                  text: "Send new Notification",
                  color: AppColors.iconBlue,
                  fontSize: 14,
                ),
                AppStyles.sbWidth32,
              ],
            ),
            PoppinsNormal500(
              text: "Notification Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows:
                  _createRows(notificationManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    (currentPage > 1)
                        ? _bloc.add(
                            NotificationLoadPreviousEvent(),
                          )
                        : SizedBox();
                    // setState(() {});
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: (currentPage > 1) ? Colors.black : Colors.grey,
                  ),
                  isSelected: (currentPage > 1),
                ),
                IconButton(
                  onPressed: () {
                    if (notificationManagementResponseModel.data != null &&
                        notificationManagementResponseModel
                                .data!.modifiedData !=
                            null &&
                        notificationManagementResponseModel
                                .data!.modifiedData!.totalCount !=
                            null) {
                      int totalItems = notificationManagementResponseModel
                          .data!.modifiedData!.totalCount!;
                      int itemsPerPage = 10;
                      int totalPages = (totalItems / itemsPerPage).ceil();
                      int nextPage = currentPage + 1;

                      if (nextPage <= totalPages) {
                        _bloc.add(NotificationLoadMoreEvent());
                      } else {
                        // Last page reached, do not load more
                        // You can show a message or handle it as needed
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
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
      DataColumn(
          label: PoppinsNormal500(
              text: 'Notification Message',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(text: 'User Types', fontSize: 12)),
      const DataColumn(label: PoppinsNormal500(text: 'Date', fontSize: 12)),
      const DataColumn(
          label: PoppinsNormal500(
        text: 'Time',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      )),
    ];
  }

  List<DataRow> _createRows(
      NotificationManagementResponseModel notificationManagementResponseModel,
      int currentPage) {
    List<DataRow> dataRow = [];
    List<UserData>? data =
        notificationManagementResponseModel.data?.modifiedData?.userdata;
    for (int i = 0; i < data!.length; i++) {
      int itemCount = (currentPage - 1) * 10 + i + 1;
      DateTime dt = DateTime.parse(data[i].createdAt ?? "");
      DataRow dataRowObject = DataRow(cells: [
        DataCell(Text("$itemCount")),
        DataCell(Text(
          "${data[i].message}",
          softWrap: true,
        )),
        DataCell(Text("${data[i].target}")),
        DataCell(Text(DateTimeHelper.getCustomDateFormat(dt))),
        DataCell(Text(DateTimeHelper.getTime(dt))),
      ]);
      dataRow.add(dataRowObject);
    }
    return dataRow;
  }
}
