import 'package:flutter/material.dart';
import '../models/distress_data.dart';
import '../utils/severity_colors.dart';

class SeverityTile extends StatelessWidget {
  final DistressData data;

  const SeverityTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: SeverityCalculator.getSeverityColor(data.severity),
        ),
        title: Text('Location: ${data.startLat.toStringAsFixed(4)}, ${data.startLon.toStringAsFixed(4)}'),
        subtitle: Text('Severity: ${data.severity.toStringAsFixed(2)}'),
        trailing: Text(
          '${(data.severity * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: SeverityCalculator.getSeverityColor(data.severity),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}