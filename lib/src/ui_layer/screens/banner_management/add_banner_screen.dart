import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/common_app_bar.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({super.key});

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithAppBar(
        appBar: CommonAppBar(),
        body: Center(
          child: Text("Add Banner"),
        ));
  }
}
