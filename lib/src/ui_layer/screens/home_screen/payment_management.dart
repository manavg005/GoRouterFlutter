import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/payment_management_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/payment_management_response.dart';
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
  const PaymentManagementScreen({Key? key}) : super(key: key);

  @override
  State<PaymentManagementScreen> createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  final PaymentManagementBloc _bloc = PaymentManagementBloc();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Timer? _debounce;
  String selectedPeriod = 'yearly';

  @override
  void initState() {
    super.initState();
    _bloc.add(PaymentManagementInitialEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: BlocBuilder<PaymentManagementBloc, PaymentManagementState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is PaymentManagementLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PaymentManagementSuccessState) {
            return _buildBody(context, state.paymentManagementResponseModel,
                state.currentPage);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PaymentManagementResponseModel paymentManagementResponseModel,
    int currentPage,
  ) {
    int totalPages = 0;

    if (paymentManagementResponseModel.data != null &&
        paymentManagementResponseModel.data!.userData != null &&
        paymentManagementResponseModel.data!.userData!.totalCount != null) {
      int totalItems =
          paymentManagementResponseModel.data!.userData!.totalCount!;
      int itemsPerPage = 10;
      totalPages = (totalItems / itemsPerPage).ceil();
    }

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
            searchTextFields(currentPage),
            AppStyles.sbWidth10,
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(paymentManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    int previousPage = currentPage - 1;
                    _handlePageNavigation(previousPage);
                  },
                  isButtonEnabled: currentPage > 1,
                ),
                CommonIconButton(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    int nextPage = currentPage + 1;

                    if (nextPage <= totalPages) {
                      _handlePageNavigation(nextPage);
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

  Widget CommonIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isButtonEnabled = true,
  }) {
    return isButtonEnabled
        ? IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: isButtonEnabled ? Colors.black : Colors.grey,
            ),
          )
        : SizedBox();
  }

  Widget searchTextFields(int currentPage) {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            controller: _startDateController,
            hint: "Start Date",
            suffixIcon: AppIcons.calenderIcon,
            onSuffixTap: () {
              _calendar(true, currentPage);
            },
            onChanged: (p0) => log("Start Date==>>>>$p0"),
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
              _calendar(false, currentPage);
            },
            onChanged: (p0) {
              _bloc.add(PaymentManagementSearchEvent(
                searchQuery: _searchController.text,
                page: currentPage,
                monthlyYearly: "yearly",
                startDate: _startDateController.text,
                endDate: _endDateController.text,
              ));
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
                items: <String>['yearly', 'monthly'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: () {
                      _bloc.add(PaymentManagementSearchEvent(
                        searchQuery: _searchController.text,
                        page: currentPage,
                        monthlyYearly: value,
                        startDate: _startDateController.text,
                        endDate: _endDateController.text,
                      ));
                    },
                    child: Text(
                      value,
                      style: AppStyles.subtitleStyle(
                        color: AppColors.textColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        AppStyles.sbWidth24,
        Expanded(
          child: SearchTextField(
            controller: _searchController,
            hint: "Search by Name",
            onChanged: (query) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();

              _debounce = Timer(Duration(milliseconds: 500), () {
                currentPage = 1;
                _bloc.add(PaymentManagementSearchEvent(
                  searchQuery: _searchController.text,
                  page: currentPage,
                  monthlyYearly: selectedPeriod,
                  startDate: _startDateController.text,
                  endDate: _endDateController.text,
                ));
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _calendar(bool isStartDate, int currentPage) async {
    final DateTime? picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      context: context,
    );
    if (picked != null) {
      if (isStartDate) {
        _startDateController.text =
            DateTimeHelper.getCustomCalenderDateFormat(picked);
        log(_startDateController.text);
      } else {
        _endDateController.text =
            DateTimeHelper.getCustomCalenderDateFormat(picked);
        _bloc.add(PaymentManagementSearchEvent(
          searchQuery: _searchController.text,
          page: currentPage,
          monthlyYearly: "yearly",
          startDate: _startDateController.text,
          endDate: _endDateController.text,
        ));
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
      const DataColumn(
        label: Expanded(
          child: Text(
            'User Name',
            softWrap: true,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createRows(
    PaymentManagementResponseModel paymentManagementResponseModel,
    int currentPage,
  ) {
    List<DataRow> dataRow = [];

    List<ModifiedData>? data =
        paymentManagementResponseModel.data?.userData?.modifiedData;

    if (data == null || data.isEmpty) {
      dataRow.add(const DataRow(cells: [
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Center(child: Text('No data found'))),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
      ]));
    } else {
      for (int i = 0; i < data.length; i++) {
        int itemCount = (currentPage - 1) * 10 + i + 1;
        DateTime dt = DateTime.parse(data[i].createdAt ?? "");
        dataRow.add(DataRow(cells: [
          DataCell(Text("$itemCount")),
          DataCell(Text("${data[i].paymentId}")),
          DataCell(Text(DateTimeHelper.getCustomDateFormat(dt))),
          DataCell(Text(DateTimeHelper.getTime(dt))),
          DataCell(Text("${data[i].bookingId}")),
          DataCell(Text("${data[i].amount}")),
          DataCell(Text(data[i].customer ?? "")),
        ]));
      }
    }
    return dataRow;
  }

  void _handlePageNavigation(int page) {
    _bloc.add(PaymentManagementSearchEvent(
      searchQuery: _searchController.text,
      page: page,
      monthlyYearly: selectedPeriod,
      startDate: _startDateController.text,
      endDate: _endDateController.text,
    ));
  }
}
