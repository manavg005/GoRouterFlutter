import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/banner_management/banner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/response/banner_management_response.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/numbers.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_switch.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/data_table.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';

class BannerManagementScreen extends StatefulWidget {
  const BannerManagementScreen({Key? key}) : super(key: key);

  @override
  State<BannerManagementScreen> createState() => _BannerManagementScreenState();
}

class _BannerManagementScreenState extends State<BannerManagementScreen> {
  final BannerBloc _bloc = BannerBloc();
  final TextEditingController _searchController = TextEditingController();
  bool isSelected = false;
  Timer? _debounce;

  void toggleSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(BannerInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: BlocBuilder<BannerBloc, BannerState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is BannerLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BannerSuccessState) {
            return _buildBody(context, state.bannerManagementResponseModel,
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
      BannerManagementResponseModel bannerManagementResponseModel,
      int currentPage) {
    int totalPages = 0;

    if (bannerManagementResponseModel.data != null &&
        bannerManagementResponseModel.data!.bannerData != null &&
        bannerManagementResponseModel.data!.bannerData!.totalCount != null) {
      int totalItems =
          bannerManagementResponseModel.data!.bannerData!.totalCount!;
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
                    const PoppinsLight400(text: "Dashboard", fontSize: 12),
                    AppIcons.arrowRight,
                    const PoppinsLight400(
                        text: "Banner Management", fontSize: 12),
                  ],
                ),
                const Spacer(),
                CommonAppButton(
                  onTap: () {
                    context.go('/banner-management/add-banner');
                  },
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
                  onChanged: (query) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();

                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      currentPage = 1;
                      // _userManagementBloc.add(UserManagementInitialEvent(
                      //     searchQuery: _searchController.text,
                      //     page: currentPage));
                      _bloc.add(BannerSearchEvent(
                          searchQuery: _searchController.text,
                          page: currentPage));
                    });
                  },
                ))
              ],
            ),
            const PoppinsNormal500(
              text: "Banner Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            CommonDataTable(
              columns: _createColumns(),
              rows: _createRows(bannerManagementResponseModel, currentPage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    int previousPage = currentPage - 1;
                    return _bloc.add(BannerSearchEvent(
                        searchQuery: _searchController.text,
                        page: previousPage));
                  },
                  isButtonEnabled: currentPage > 1,
                ),
                CommonIconButton(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    int nextPage = currentPage + 1;
                    log("$nextPage");
                    if (nextPage <= totalPages) {
                      return _bloc.add(BannerSearchEvent(
                          searchQuery: _searchController.text, page: nextPage));
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

  List<DataRow> _createRows(
      BannerManagementResponseModel bannerManagementResponseModel,
      int currentPage) {
    List<DataRow> dataRow = [];
    List<ModifiedData>? data =
        bannerManagementResponseModel.data?.bannerData?.modifiedData;
    for (int i = 0; i < data!.length; i++) {
      int itemCount = (currentPage - 1) * 10 + i + 1;
      DataRow dataRowObject = DataRow(cells: [
        DataCell(Text("$itemCount")),
        // DataCell(SizedBox(height: 27, child: AppImages.bannerImage)),
        DataCell(Image.network(
                "https://t4.ftcdn.net/jpg/05/57/64/09/360_F_557640907_PPaRsbaFsPmhq686VA3qQm4tWy0D6pk3.jpg")
            // CommonNetworkImage(
            //   // showPlaceholderWidget: false,
            //   // showErrorIcon: false,
            //   height: 27,
            //   imageUrl: " ${data[i].imageUrl}",
            //   fit: BoxFit.fitHeight,
            // ),
            ),
        DataCell(Text("${data[i].name}")),
        DataCell(CommonSwitch(
          value: data[i].status == 2 ? true : false,
          id: data[i].sId ?? "",
          screenType: CommonSwitchScreen.banner,
          bloc: _bloc,
        )),
      ]);
      dataRow.add(dataRowObject);
    }
    return dataRow;
  }
}
