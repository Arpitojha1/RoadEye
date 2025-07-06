import 'package:flutter/material.dart';
import '../services/shared_data.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = SharedData.parsedRoadData;

    if (data == null || data.isEmpty) {
      return Center(
        child: Text(
          'No data uploaded yet.\nPlease upload a valid NSV Excel file.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Pavement Condition Dashboard")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final segment = data[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 4,
            child: ListTile(
              title: Text(
                "Chainage: ${segment['startChainage']} - ${segment['endChainage']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Cracking: ${segment['cracking']}%  |  "
                "Rutting: ${segment['rutting']} mm  |  "
                "Roughness: ${segment['roughness']} IRI",
              ),
            ),
          );
        },
      ),
    );
  }
}
