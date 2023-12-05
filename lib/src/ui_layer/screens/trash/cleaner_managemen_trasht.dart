import 'package:flutter/material.dart';

class CleanerManagementScreen extends StatefulWidget {
  const CleanerManagementScreen({Key? key}) : super(key: key);

  @override
  _CleanerManagementScreenState createState() =>
      _CleanerManagementScreenState();
}

class _CleanerManagementScreenState extends State<CleanerManagementScreen> {
  final List<CleanerData> _cleaners = List.generate(100, (index) {
    return CleanerData(
      id: index,
      name: 'Cleaner $index',
      email: 'cleaner$index@example.com',
      mobile: '1234567890',
      registrationDate: '22-10-2023',
    );
  });

  final int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Text('Cleaner Management'),
      columns: _createColumns(),
      source: _MyDataTableSource(_cleaners),
      rowsPerPage: _rowsPerPage,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Mobile')),
      DataColumn(label: Text('Registration Date')),
    ];
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<CleanerData> _cleaners;

  _MyDataTableSource(this._cleaners);

  @override
  DataRow getRow(int index) {
    final cleaner = _cleaners[index];
    return DataRow(cells: [
      DataCell(Text(cleaner.id.toString())),
      DataCell(Text(cleaner.name)),
      DataCell(Text(cleaner.email)),
      DataCell(Text(cleaner.mobile)),
      DataCell(Text(cleaner.registrationDate)),
    ]);
  }

  @override
  int get rowCount => _cleaners.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

/// Sample Model for cleaner management

class CleanerData {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String registrationDate;

  CleanerData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.registrationDate,
  });
}
