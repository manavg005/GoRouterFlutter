import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';

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
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          scrollDirection:
              Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
          child: SizedBox(
            width: Responsive.isTablet(context)
                ? MediaQuery.of(context).size.width - diff
                : null,
            child: Responsive.isDesktop(context)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      // columnSpacing: MediaQuery.of(context).size.width/(2*widget.columns.length),
                      // columnSpacing: 100,
                      horizontalMargin: 10, // Adjust as needed
                      columnSpacing: 10, // Adjust as needed
                      columns: widget.columns,
                      rows: widget.rows,
                      headingRowColor: const MaterialStatePropertyAll(
                          AppColors.backgroundColor),
                      headingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.backgroundColor,
                          style: BorderStyle.solid),
                    ),
                  )
                : DataTable(
                    // columnSpacing: MediaQuery.of(context).size.width/(2*widget.columns.length),
                    columnSpacing: 30,
                    columns: widget.columns,
                    rows: widget.rows,
                    headingRowColor: const MaterialStatePropertyAll(
                        AppColors.backgroundColor),
                    headingTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.backgroundColor,
                        style: BorderStyle.solid),
                  ),
          ),
        ),
      )
    ]);
  }
}

/*
TableBorder(
borderRadius: BorderRadius.circular(10),
horizontalInside: BorderSide(
color: AppColors.backgroundColor,
),

Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Responsive.isDesktop(context)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      // columnSpacing: MediaQuery.of(context).size.width/(2*widget.columns.length),
                      // columnSpacing: 100,
                      columns: widget.columns,
                      rows: widget.rows,
                      headingRowColor: const MaterialStatePropertyAll(
                          AppColors.backgroundColor),
                      headingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.backgroundColor,
                          style: BorderStyle.solid),
                    ),
                  )
                : DataTable(
                    // columnSpacing: MediaQuery.of(context).size.width/(2*widget.columns.length),
                    columnSpacing: 30,
                    columns: widget.columns,
                    rows: widget.rows,
                    headingRowColor: const MaterialStatePropertyAll(
                        AppColors.backgroundColor),
                    headingTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.backgroundColor,
                        style: BorderStyle.solid),
                  ),
          ),
        ),
      ],
    );








import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

import '../../data_layer/res/colors.dart';

class CommonDataTable extends StatefulWidget {
  const CommonDataTable({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  final List<DataColumn> columns;
  final List<DataRow> rows;

  @override
  _CommonDataTableState createState() => _CommonDataTableState();
}

class _CommonDataTableState extends State<CommonDataTable> {
  @override
  Widget build(BuildContext context) {
    int diff = Responsive.isDesktop(context) ? 280 : Responsive.isTablet(context) ? 100 : 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SingleChildScrollView(
        scrollDirection: Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
        child: SizedBox(
          width: Responsive.isTablet(context)
              ? MediaQuery.of(context).size.width - diff
              : null,
          child: DataTable(
            columns: widget.columns,
            rows: widget.rows,
            headingRowColor: const MaterialStatePropertyAll(AppColors.backgroundColor),
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            dividerThickness: 0.5,
            horizontalMargin: 10, // Adjust as needed
            columnSpacing: 10, // Adjust as needed
            showBottomBorder: true,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.backgroundColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

)*/
