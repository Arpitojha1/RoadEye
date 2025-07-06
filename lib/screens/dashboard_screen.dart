import 'package:flutter/material.dart';
import '../services/shared_data.dart';  // Correct import path
import '../widgets/severity_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = SharedData.instance.distressData;  // Correct access
    
    return Scaffold(
      appBar: AppBar(title: const Text('Road Condition Dashboard')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SeverityTile(data: data[index]);
        },
      ),
    );
  }
}