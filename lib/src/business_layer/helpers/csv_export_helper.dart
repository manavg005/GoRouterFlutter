import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:csv/csv.dart';

class CsvHelper {
  static Future<void> exportToCSV(
      List<List<dynamic>> rows, String fileName) async {
    final csvData = const ListToCsvConverter().convert(rows);
    final blob = html.Blob([Uint8List.fromList(utf8.encode(csvData))]);

    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'download'
      ..download = '$fileName.csv';
    html.document.body!.children.add(anchor);

    anchor.click();

    // Cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
