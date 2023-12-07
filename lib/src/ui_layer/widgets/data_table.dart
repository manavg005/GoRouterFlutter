import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

import '../../data_layer/res/colors.dart';

class CommonDataTable extends StatefulWidget {
  const CommonDataTable({super.key, required this.columns, required this.rows});

  final List<DataColumn> columns;
  final List<DataRow> rows;
  @override
  State<CommonDataTable> createState() => _CommonDataTableState();
}

class _CommonDataTableState extends State<CommonDataTable> {
  @override
  Widget build(BuildContext context) {
    int diff = Responsive.isDesktop(context)
        ? 280
        : Responsive.isTablet(context)
            ? 100
            : 0;
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - diff,
                child: DataTable(
                  columns: widget.columns,
                  rows: widget.rows,
                  headingRowColor:
                      MaterialStatePropertyAll(AppColors.backgroundColor),
                  headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.backgroundColor,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        ]);
  }
}

/*
TableBorder(
borderRadius: BorderRadius.circular(10),
horizontalInside: BorderSide(
color: AppColors.backgroundColor,
),
)*/
