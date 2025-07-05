import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/dummy_loader.dart';
import '../utils/severity_colors.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = DummyLoader.load();

    // If no data is available, show a message instead of crashing
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Map View")),
        body: Center(
          child: Text(
            "No distress data available.",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Map View")),
      body: FlutterMap(
        options: MapOptions(
          center: data[0].location, // Safe now because data is not empty
          zoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerWidget(
            options: MarkerLayerOptions(
              markers: data.map((d) => Marker(
                width: 20,
                height: 20,
                point: d.location,
                builder: (ctx) => Icon(
                  Icons.circle,
                  color: getColorFromSeverity(d.severityScore),
                  size: 16, // Slightly larger for visibility
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
