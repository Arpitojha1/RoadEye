import 'package:flutter/material.dart';

Color getColorFromSeverity(double score) {
  if (score < 0.3) return Colors.green;
  if (score < 0.6) return Colors.orange;
  return Colors.red;
}
