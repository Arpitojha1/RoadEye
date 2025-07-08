import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../models/distress_data.dart';
import '../utils/severity_colors.dart';

class ExcelParser {
  static Future<List<DistressData>> parseExcelBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      final excel = Excel.decodeBytes(bytes);
      final sheet = excel.tables[' Comparison with CA@100m'] ?? 
                   excel.tables.values.first;

      List<DistressData> data = [];

      for (var i = 3; i < sheet.rows.length; i++) {
        try {
          final row = sheet.rows[i];
          if (row.length < 67) continue;

          // Skip if coordinates are invalid (blank, text, or invalid numbers)
          final lat = _tryParseCoordinate(row[5]);
          final lon = _tryParseCoordinate(row[6]);
          if (lat == null || lon == null) {
            debugPrint('Skipping row $i - Invalid coordinates');
            continue;
          }

          // Skip if coordinates are outside India
          if (!_isValidIndianCoordinate(lat, lon)) {
            debugPrint('Skipping row $i - Coordinates outside India: ($lat, $lon)');
            continue;
          }

          data.add(DistressData(
            lane: 'L1',
            startLat: lat,
            startLon: lon,
            roughness: _safeParse(row[43]),
            rutting: _safeParse(row[45]),
            cracking: _parsePercentage(row[54]),
            ravelling: _parsePercentage(row[66]),
            region: "plains",
            severity: SeverityCalculator.calculateSeverity(
              roughness: _safeParse(row[43]),
              rutting: _safeParse(row[45]),
              cracking: _parsePercentage(row[54]),
              ravelling: _parsePercentage(row[66]),
            ),
          ));
        } catch (e) {
          debugPrint('Error parsing row $i: $e');
        }
      }
      return data;
    } catch (e) {
      throw Exception('Excel parsing failed: ${e.toString()}');
    }
  }

  /// Returns null for invalid coordinates (blank, text, or non-Indian numbers)
  static double? _tryParseCoordinate(Data? cell) {
    try {
      // Skip empty cells
      if (cell == null || cell.value == null) return null;
      
      // Handle numeric values directly
      if (cell.value is num) {
        return (cell.value as num).toDouble();
      }

      // Parse string values
      final strValue = cell.value.toString().trim();
      if (strValue.isEmpty) return null;

      // Skip text values (contains letters)
      if (RegExp(r'[a-zA-Z]').hasMatch(strValue)) return null;

      final value = double.tryParse(strValue);
      return value;
    } catch (_) {
      return null;
    }
  }

  static bool _isValidIndianCoordinate(double lat, double lon) {
    return lat >= 8.0 && lat <= 37.0 && // India latitude range
           lon >= 68.0 && lon <= 97.0;  // India longitude range
  }

  static double _parsePercentage(Data? cell) {
    try {
      String value = cell?.value.toString().trim() ?? '0';
      value = value.replaceAll('%', '');
      return double.parse(value) / 100;
    } catch (_) {
      return 0.0;
    }
  }

  static double _safeParse(Data? cell) {
    try {
      return double.parse(cell?.value.toString().trim() ?? '0');
    } catch (_) {
      return 0.0;
    }
  }
}