import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/notification_management/notification_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/models/request/send_notification_request.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_buttons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text_field.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_dropdown_widget.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({Key? key}) : super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedTarget;

  NotificationBloc _bloc = NotificationBloc();

  @override
  void initState() {
    _bloc.add(NotificationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
      appBar: CommonAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
                      text: "Notification Management",
                      fontSize: 12,
                    ),
                    AppIcons.arrowRight,
                    const PoppinsLight400(
                        text: "Send new  notification", fontSize: 12),
                  ],
                ),
              ],
            ),
            AppStyles.sbHeight10,
            const PoppinsNormal500(
              text: "Notification Management",
              fontSize: 20,
            ),
            AppStyles.sbHeight34,
            detailContainer(),
          ],
        ),
      ),
    );
  }

  Widget detailContainer() {
    List<String> dropDownItems = ["All", "All Customers", "All Cleaners"];
    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: _bloc,
      builder: (context, state) {
        return Container(
            // height: 50,
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.greyDisabledTextField,
            ),
            child: Column(
              children: [
                CommonTextFieldWithTitle(
                  controller: _titleController,
                  title: "Notification Title",
                ),
                AppStyles.sbHeight10,
                CommonTextFieldWithTitle(
                  controller: _messageController,
                  title: "Notification Message",
                  maxLength: 200,
                  minline: 10,
                  maxline: 10,
                ),
                AppStyles.sbHeight10,
                CommonDropdownWidget(
                    headerText: "Select User Type",
                    hintText: "hintText",
                    dropDownItems: dropDownItems,
                    selectDetail: (selectValue) {
                      _selectedTarget = selectValue;
                      log(selectValue);
                    }),
                Row(
                  children: [
                    AnimatedButton(
                      title: "Cancel",
                      buttonColor: AppColors.greyColor,
                      buttonBorderColor: AppColors.ceruleanBlue,
                    ),
                    AppStyles.sbWidth5,
                    AnimatedButton(
                      onPressed: () {
                        _bloc.add(SendNotificationEvent(
                            sendNotificationRequestModel: _sendRequestModel));
                      },
                      title: "Send",
                      titleTextStyle:
                          const TextStyle(color: AppColors.whiteColor),
                      buttonColor: AppColors.ceruleanBlue,
                      // buttonBorderColor: AppColors.ceruleanBlue,
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }

  SendNotificationRequestModel get _sendRequestModel =>
      SendNotificationRequestModel(
          title: _titleController.text,
          message: _messageController.text,
          target: _selectedTarget);
}
