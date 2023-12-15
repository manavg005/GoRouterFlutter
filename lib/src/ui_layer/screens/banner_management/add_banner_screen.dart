import 'dart:developer';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/banner_management/banner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/route_names.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/helper/validator.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/add_banner_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({super.key});

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bannerNameController = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  Uint8List? _fileByte;

  final BannerBloc _bloc = BannerBloc();
  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
        appBar: CommonAppBar(), body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
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
                        text: "Banner Management", fontSize: 12),
                    AppIcons.arrowRight,
                    const PoppinsLight400(text: "Add new banner", fontSize: 12),
                  ],
                ),
              ],
            ),
            AppStyles.sbHeight10,
            const PoppinsNormal500(
              text: "New Banner",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            _bannerContainer(context),
          ],
        ),
      ),
    );
  }

  /// banner Container
  Widget _bannerContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.greyLightShadeColor)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              // width: MediaQuery.of(context).size.width / 2.5,
              controller: _bannerNameController,
              hint: 'Enter Banner Name',
              labelText: 'Banner Name',
              labelTextColor: AppColors.blackColor,
              validator: (value) =>
                  ValidatorHelper.nonEmptyValidation(value, "Banner name"),
              labelTextSize: 16,
              radius: 5,
            ),
            AppStyles.sbHeight15,
            const PoppinsNormal500(
              text: "Image ",
              fontSize: 16,
              color: AppColors.blackColor,
            ),
            AppStyles.sbHeight24,
            _selectFileContainer(),
            AppStyles.sbHeight34,
            _uploadAndCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _selectFileContainer() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      color: AppColors.blackColor.withOpacity(0.25),
      dashPattern: const [6, 6, 6, 6],
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 56),
          height: 350,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.uploadIcon,
              AppStyles.sbHeight24,
              const PoppinsLight400(
                text: "Select a file or drag and drop here",
                fontSize: 13,
                color: AppColors.blackColor,
              ),
              AppStyles.sbHeight10,
              PoppinsLight400(
                text:
                    "JPG, PNG or PDF, file size no more than 10MB.         Suggested Dimensions 335x124",
                fontSize: 12,
                color: AppColors.blackColor.withOpacity(0.4),
              ),
              AppStyles.sbHeight24,
              _selectFileButton(),
              AppStyles.sbHeight10,
              PoppinsLight400(
                text: _fileNameController.text,
                fontSize: 12,
                color: AppColors.redColor,
              )
            ],
          )),
    );
  }

  /// Cancel And Upload button Widget
  Widget _uploadAndCancelButton(BuildContext context) {
    return Row(
      children: [
        _cancelButton(),
        AppStyles.sbWidth10,
        _uploadButton(context),
      ],
    );
  }

  Widget _selectFileButton() {
    return InkWell(
      onTap: () async {
        await _pickFile();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.iconBlue)),
        width: 95,
        height: 35,
        padding: const EdgeInsets.only(top: 12, left: 16),
        child: const PoppinsLight400(
          text: "SELECT FILE",
          fontSize: 10,
          color: AppColors.iconBlue,
        ),
      ),
    );
  }

  /// Upload button Widget
  Widget _uploadButton(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
      bloc: _bloc,
      builder: (context, state) {
        return AnimatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_bannerNameController.text.isNotEmpty && _fileByte != null) {
                _bloc.add(
                    AddBannerEvent(bannerImageRequestModel: _requestModel));
              }
            }
          },
          loading: state is BannerLoadingState ? true : false,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 44),
          width: 180,
          borderRadius: 5,
          buttonColor: AppColors.iconBlue,
          title: "Upload",
          titleTextStyle:
              const TextStyle(fontSize: 14, color: AppColors.whiteColor),
        );
      },
      listener: (BuildContext context, BannerState state) {
        if (state is BannerNavigateActionState) {
          context.goNamed(RouteNames.bannerManagement);
        }
      },
    );
  }

  Widget _cancelButton() {
    return AnimatedButton(
      onPressed: () {},
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 44),
      width: 180,
      borderRadius: 5,
      buttonColor: AppColors.whiteColor,
      buttonBorderColor: AppColors.iconBlue,
      title: "Cancel",
      titleTextStyle: const TextStyle(
        fontSize: 14,
        color: AppColors.iconBlue,
      ),
    );
  }

  /// Pick files
  Future<void> _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    // print("result ==>${result}");
    if (result != null && result.files.isNotEmpty) {
      Uint8List? fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      // log(fileName);
      // log("${fileBytes}");
      setState(() {
        _fileNameController.text = fileName;
        _fileByte = fileBytes;
      });
    }
  }

  UploadBannerImageRequestModel get _requestModel =>
      UploadBannerImageRequestModel(
        bannerName: _bannerNameController.text,
        file: _fileByte,
      );
}
