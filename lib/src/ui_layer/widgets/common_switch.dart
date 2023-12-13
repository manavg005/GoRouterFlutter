import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/banner_management/banner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/cleaner_management/cleaner_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/blocs/user_management/user_management_bloc.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/helpers/enums.dart';

class CommonSwitch extends StatefulWidget {
  CommonSwitch(
      {Key? key,
      required this.value,
      required this.id,
      required this.screenType,
      required this.bloc})
      : super(key: key);

  bool value;
  String id;
  CommonSwitchScreen screenType;
  Bloc bloc;

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
        onChanged: (value) async {
          _getScreenType(widget.screenType, value);
        },
      ),
    );
  }

  Future<void> _activeInactiveUserApiCall(bool switchValue) async {
    widget.bloc.add(UserActiveInactiveEvent(userId: widget.id));
    setState(() {
      widget.value = switchValue;
    });
  }

  Future<void> _activeInactiveCleanerApiCall(bool switchValue) async {
    widget.bloc.add(CleanerActiveInactiveEvent(userId: widget.id));
    setState(() {
      widget.value = switchValue;
    });
  }

  Future<void> _activeInactiveBannerApiCall(bool switchValue) async {
    widget.bloc.add(BannerActiveInactive(bannerId: widget.id));
    setState(() {
      widget.value = switchValue;
    });
  }

  void _getScreenType(CommonSwitchScreen screenType, bool switchValue) {
    switch (screenType) {
      case CommonSwitchScreen.user:
        _activeInactiveUserApiCall(switchValue);
        break;
      case CommonSwitchScreen.cleaner:
        _activeInactiveCleanerApiCall(switchValue);
        break;
      case CommonSwitchScreen.banner:
        _activeInactiveBannerApiCall(switchValue);
        break;
    }
  }
}
