import 'package:flutter/material.dart';
import '../services/dummy_loader.dart';
import '../widgets/severity_tile.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = DummyLoader.load();

    return Scaffold(
      appBar: AppBar(title: Text("Distress Dashboard")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) => SeverityTile(data[index]),
      ),
    );
  }
}