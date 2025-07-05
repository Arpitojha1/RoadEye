import 'dart:io';
import 'package:excel/excel.dart';

class ExcelParser {
  static Future<List<Map<String, dynamic>>> parse(File file) async {
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> results = [];

    for (final table in excel.tables.keys) {
      final sheet = excel.tables[table];
      if (sheet == null) continue;

      for (int i = 1; i < sheet.rows.length; i++) {
        final row = sheet.rows[i];

        try {
          results.add({
            'latitude': row[0]?.value,   // adjust based on actual column index
            'longitude': row[1]?.value,
            'roughness': row[2]?.value,
            'rutting': row[3]?.value,
            'cracking': row[4]?.value,
          });
        } catch (e) {
          print("Skipping bad row: $i");
        }
      }
    }

    return results;
  }
}
