import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_alert_dialog.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

class BookingManagementScreen extends StatefulWidget {
  const BookingManagementScreen({Key? key}) : super(key: key);

  @override
  State<BookingManagementScreen> createState() =>
      _BookingManagementScreenState();
}

class _BookingManagementScreenState extends State<BookingManagementScreen> {
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 22),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topTextAndSearchField(),
                  const PoppinsNormal500(
                    text: "Booking Management",
                    fontSize: 20,
                  ),
                  AppStyles.sbHeight34,
                ],
              ),
              _buildTabBar(),
              Expanded(
                child: _buildTabBarView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        _buildNewBookingTab(),
        _buildAcceptedBookingTab(),
        _buildPastBookingTab(),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: [
        Tab(
            icon: Row(
          children: [Text('New Booking'), AppIcons.redIndicator],
        )),
        Tab(icon: Text('Accepted Booking')),
        Tab(icon: Text('Past Booking(completed/ Cancelled/ Rejected)')),
      ],
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: AppColors.iconBlue,
      labelColor: AppColors.iconBlue,
    );
  }

  Widget topTextAndSearchField() {
    return Row(
      children: [
        topNavigationRouteText(),
        Spacer(),
        InkWell(onTap: () {}, child: AppIcons.downloadIcon),
        const CommonText(
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
    );
  }

  Widget topNavigationRouteText() {
    return Row(
      children: [
        PoppinsLight400(text: "Dashboard", fontSize: 12),
        AppIcons.arrowRight,
        PoppinsLight400(text: "Booking Management", fontSize: 12),
      ],
    );
  }

  Widget _buildNewBookingTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
      child: SingleChildScrollView(
        child: CommonDataTable(
          columns: _createColumns(),
          rows: _createRows(),
        ),
      ),
    );
  }

  Widget _buildAcceptedBookingTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
      child: SingleChildScrollView(
          child: CommonDataTable(
        columns: _createColumns(),
        rows: _createRows(),
      )),
    );
  }

  Widget _buildPastBookingTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
      child: SingleChildScrollView(
        child: CommonDataTable(
          columns: _createColumns(),
          rows: _createRows(),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Booking Id',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Customer Name.',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Cleaner Name',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Date', fontSize: 12, overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
        text: 'Time',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      )),
      const DataColumn(
          label: PoppinsNormal500(
        text: 'Total Charges',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      )),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Payment Status',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
      const DataColumn(
          label: PoppinsNormal500(
              text: 'Booking Details',
              fontSize: 12,
              overflow: TextOverflow.ellipsis)),
    ];
  }

  List<DataRow> _createRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < 10; i++) {
      dataRow.add(DataRow(cells: [
        DataCell(Text("1")),
        const DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(child: Image.asset("assets/images/app_logo.png")),
            Text("Username"),
          ],
        )),
        DataCell(Text("Name")),
        DataCell(Text("DD/MM/YYYY")),
        DataCell(Text("3:02 AM")),
        DataCell(Text("\$ 200")),
        DataCell(Text("Done")),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomDetailsDialog(
                      bookingType: MyBookingTab.newBooking,
                      progressStatus: BookingProgressStatus.pending,
                    );
                  });
            },
            icon: AppIcons.eyeIcon)),
      ]));
    }
    return dataRow;
  }
}

/*
 DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(icon: Text('Tab ONE')),
                      Tab(icon: Text('Tab TWO')),
                      Tab(icon: Text('Tab THREE')),
                    ],
                  ),
                  // TabBarView(children: [
                  //   Text("Tab 1 Content"),
                  //   Text("Tab 2 Content"),
                  // ]),
                ],
              ),
            ),
 */
