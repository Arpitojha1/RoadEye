import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';

Future<void> loadNSVData() async {
  final rawData = await rootBundle.load("assets/data/nsv_report.xlsx");
  final excel = Excel.decodeBytes(rawData.buffer.asUint8List());

  final sheet = excel.tables[excel.tables.keys.first];
  for (var row in sheet!.rows.skip(1)) {
    print(row.map((cell) => cell?.value));
    // TODO: Parse into model like DistressData
  }
}
