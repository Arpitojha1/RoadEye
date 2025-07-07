import 'package:latlong2/latlong.dart';
import 'package:excel/excel.dart';
import 'dart:typed_data';

class ExcelParser {
  static List<LatLng> extractAllLaneCoordinates(Excel excel) {
    List<LatLng> coordinates = [];

    var sheet = excel.tables['Comparison with CA@100m'];
    if (sheet == null) return coordinates;

    final laneColumns = {
      'L1': [5, 6, 8, 9],
      'L2': [11, 12, 14, 15],
      'L3': [17, 18, 20, 21],
      'L4': [23, 24, 26, 27],
      'R1': [29, 30, 32, 33],
      'R2': [35, 36, 38, 39],
    };

    for (var rowIndex = 3; rowIndex < sheet.rows.length; rowIndex++) {
      var row = sheet.rows[rowIndex];
      for (var lane in laneColumns.entries) {
        try {
          double startLat = _safeParse(row[lane.value[0]]);
          double startLng = _safeParse(row[lane.value[1]]);
          double endLat = _safeParse(row[lane.value[2]]);
          double endLng = _safeParse(row[lane.value[3]]);

          if (startLat != 0 && startLng != 0) {
            coordinates.add(LatLng(startLat, startLng));
          }
          if (endLat != 0 && endLng != 0) {
            coordinates.add(LatLng(endLat, endLng));
          }
        } catch (e) {
          print('⚠️ Error parsing ${lane.key} at row $rowIndex: $e');
        }
      }
    }

    return coordinates;
  }

  static double _safeParse(Data? cell) {
    return double.tryParse(cell?.value.toString().trim() ?? '') ?? 0.0;
  }

  static Future<List<LatLng>> parseExcelBytes(Uint8List bytes) async {
    try {
      final excel = Excel.decodeBytes(bytes);
      return extractAllLaneCoordinates(excel);
    } catch (e) {
      throw Exception('Error parsing Excel: $e');
    }
  }
}