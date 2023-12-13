import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/booking_management/booking_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/date_time_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/booking_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_alert_dialog.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';

import '../../widgets/app_buttons.dart';

class BookingManagementScreen extends StatefulWidget {
  const BookingManagementScreen({Key? key}) : super(key: key);

  @override
  State<BookingManagementScreen> createState() =>
      _BookingManagementScreenState();
}

class _BookingManagementScreenState extends State<BookingManagementScreen> {
  final BookingBloc _bloc = BookingBloc();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _bloc.add(BookingManagementInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(appBar: CommonAppBar(), body: _buildBody());
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
                child: BlocBuilder<BookingBloc, BookingState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is BookingManagementLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is BookingManagementSuccessState) {
                      return _buildTabBarView(
                          state.bookingManagementResponseModel,
                          state.currentPage);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(
      BookingManagementResponseModel bookingManagementResponseModel,
      int currentPage) {
    return TabBarView(
      children: [
        _buildBookingTab(MyBookingTab.newBooking,
            bookingManagementResponseModel, currentPage),
        _buildBookingTab(
            MyBookingTab.accepted, bookingManagementResponseModel, currentPage),
        _buildBookingTab(
            MyBookingTab.past, bookingManagementResponseModel, currentPage),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      onTap: (value) {
        switch (value) {
          case 0:
            _bloc.add(BookingManagementSearchEvent(
                searchQuery: "", status: 0, page: 1));
            break;
          case 1:
            _bloc.add(BookingManagementSearchEvent(
                searchQuery: "", status: 2, page: 1));
            break;
          case 2:
            _bloc.add(BookingManagementSearchEvent(
                searchQuery: "", status: 3, page: 1));
            break;
        }
      },
      tabs: [
        Tab(
          icon: Stack(
            children: [
              Row(
                children: [const Text('New Booking'), AppIcons.redIndicator],
              ),
              Positioned(
                right: 3,
                bottom: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  /*decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Adjust color as needed
                  ),*/
                  child: Text(
                    '40+', // Replace with the actual count
                    style: TextStyle(
                      color: Colors.white, // Adjust color as needed
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Tab(icon: Text('Accepted Booking')),
        const Tab(icon: Text('Past Booking(completed/ Cancelled/ Rejected)')),
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
            child: SearchTextField(
          controller: _searchController,
          hint: "Search by Name",
          prefixIcon: AppIcons.searchIcon,
          onChanged: (query) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();

            _debounce = Timer(const Duration(milliseconds: 500), () {
              // currentPage = 1;
              // _bloc.add(BookingManagementSearchEvent(
              //     searchQuery: _searchController.text,
              //     status: tabTypeToStatusCode(tabType),
              //     page: currentPage));
            });
          },
        ))
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

  Widget _buildBookingTab(
      MyBookingTab tabType,
      BookingManagementResponseModel bookingManagementResponseModel,
      int currentPage) {
    int totalPages = 0;

    if (bookingManagementResponseModel.data != null &&
        bookingManagementResponseModel.data!.userdata != null &&
        bookingManagementResponseModel.data!.userdata!.totalCount != null) {
      int totalItems =
          bookingManagementResponseModel.data!.userdata!.totalCount!;
      int itemsPerPage = 10;
      totalPages = (totalItems / itemsPerPage).ceil();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(
                  tabType, bookingManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    int previousPage = currentPage - 1;
                    return _bloc.add(BookingManagementSearchEvent(
                        searchQuery: _searchController.text,
                        status: tabTypeToStatusCode(tabType),
                        page: previousPage));
                  },
                  isButtonEnabled: currentPage > 1,
                ),
                CommonIconButton(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    int nextPage = currentPage + 1;

                    if (nextPage <= totalPages) {
                      return _bloc.add(BookingManagementSearchEvent(
                          searchQuery: _searchController.text,
                          status: tabTypeToStatusCode(tabType),
                          page: nextPage));
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

  List<DataRow> _createRows(
      MyBookingTab tabType,
      BookingManagementResponseModel bookingManagementResponseModel,
      int currentPage) {
    List<DataRow> dataRow = [];
    List<ModifiedData>? data =
        bookingManagementResponseModel.data?.userdata?.modifiedData;
    for (int i = 0; i < data!.length; i++) {
      int itemCount = (currentPage - 1) * 10 + i + 1;
      DateTime dt = DateTime.parse(data[i].createdAt ?? "");
      dataRow.add(DataRow(cells: [
        DataCell(Text("$itemCount")),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(child: Image.asset("assets/images/app_logo.png")),
            Text(data[i].customer ?? ""),
          ],
        )),
        DataCell(Text(data[i].cleaner ?? "")),
        DataCell(Text(DateTimeHelper.getCustomDateFormat(dt))),
        DataCell(Text(DateTimeHelper.getTime(dt))),
        DataCell(Text("\$ ${data[i].amount}")),
        const DataCell(Text("Done")),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDetailsDialog(
                      bookingType: MyBookingTab.newBooking,
                      progressStatus: BookingProgressStatus.pending,
                      id: data[i].sId ?? "",
                      details: data[i],
                    );
                  });
            },
            icon: AppIcons.eyeIcon)),
      ]));
    }
    return dataRow;
  }

  // Helper function to convert MyBookingTab to status code
  int tabTypeToStatusCode(MyBookingTab tabType) {
    switch (tabType) {
      case MyBookingTab.newBooking:
        return 0; // Replace with your actual status code for new bookings
      case MyBookingTab.accepted:
        return 2; // Replace with your actual status code for accepted bookings
      case MyBookingTab.past:
        return 3; // Replace with your actual status code for past bookings
    }
  }
}
