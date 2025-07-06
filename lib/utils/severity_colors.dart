// lib/utils/severity_colors.dart
import 'package:flutter/material.dart';

class SeverityCalculator {
  static Color getSeverityColor(double severity) {
    if (severity < 0.3) return Colors.green;
    if (severity < 0.6) return Colors.orange;
    return Colors.red;
  }

  static double calculateSeverity({
    required double roughness,
    required double rutting,
    required double cracking,
    required double ravelling,
  }) {
    final roughnessScore = _normalize(roughness, 800, 2400);
    final ruttingScore = _normalize(rutting, 2, 5);
    final crackingScore = _normalize(cracking, 0, 5);
    final ravellingScore = _normalize(ravelling, 0, 1);

    return (roughnessScore * 0.4) + 
           (ruttingScore * 0.3) + 
           (crackingScore * 0.2) + 
           (ravellingScore * 0.1);
  }

  static double _normalize(double value, double min, double max) {
    return ((value - min) / (max - min)).clamp(0, 1);
  }
}