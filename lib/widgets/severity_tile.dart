import 'package:flutter/material.dart';
import '../models/distress_data.dart';
import '../utils/severity_colors.dart';

class SeverityTile extends StatelessWidget {
  final DistressData data;
  const SeverityTile(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getColorFromSeverity(data.severityScore).withOpacity(0.2),
      child: ListTile(
        title: Text("Location: ${data.location.latitude}, ${data.location.longitude}"),
        subtitle: Text(
            "Roughness: ${data.roughness}, Rutting: ${data.rutting}, Cracking: ${data.cracking}"),
        trailing: Text("Severity: ${(data.severityScore * 100).toInt()}%"),
      ),
    );
  }
}
