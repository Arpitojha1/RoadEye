import 'dart:io';
import 'package:excel/excel.dart';
import '../models/distress_data.dart';
import '../utils/severity_colors.dart';

class ExcelParser {
  static Future<List<DistressData>> parseExcel(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first];

    if (sheet == null) {
      throw Exception("Excel sheet is empty");
    }

    List<DistressData> roadData = [];

    for (var row in sheet.rows.skip(1)) { // Skip header
      if (row.length >= 7) {
        roadData.add(DistressData(
          startLat: _parseDouble(row[0]?.value),
          startLon: _parseDouble(row[1]?.value),
          roughness: _parseDouble(row[2]?.value),
          rutting: _parseDouble(row[3]?.value),
          cracking: _parseDouble(row[4]?.value),
          ravelling: _parseDouble(row[5]?.value),
          region: row[6]?.value?.toString() ?? 'plains',
          severity: SeverityCalculator.calculateSeverity(
            roughness: _parseDouble(row[2]?.value),
            rutting: _parseDouble(row[3]?.value),
            cracking: _parseDouble(row[4]?.value),
            ravelling: _parseDouble(row[5]?.value),
          ),
        ));
      }
    }

    return roadData;
  }

  static double _parseDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '0') ?? 0.0;
  }
}