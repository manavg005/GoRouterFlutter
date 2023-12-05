import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/user_management/user_management_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';

class CommonSwitch extends StatefulWidget {
  CommonSwitch({
    Key? key,
    required this.value,
    required this.id,
    required this.screenType,
  }) : super(key: key);

  bool value;
  String id;
  CommonSwitchScreen screenType;

  @override
  State<CommonSwitch> createState() => _CommonSwitchState();
}

class _CommonSwitchState extends State<CommonSwitch> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: widget.value,
        onChanged: (value1) async {
          _getScreenType(widget.screenType, value1);
          // _activeInactiveUserApiCall(value1);
        },
      ),
    );
  }

  Future<void> _activeInactiveUserApiCall(bool switchValue) async {
    // widget.bloc.add(UserActiveInactiveEvent(widget.id));
  }

  Future<void> _activeInactiveCleanerApiCall(bool switchValue) async {}

  void _getScreenType(CommonSwitchScreen screenType, bool switchValue) {
    switch (screenType) {
      case CommonSwitchScreen.user:
        _activeInactiveUserApiCall(switchValue);
        break;
      case CommonSwitchScreen.cleaner:
        _activeInactiveCleanerApiCall(switchValue);
        break;
      case CommonSwitchScreen.notification:
        break;
    }
  }
}
