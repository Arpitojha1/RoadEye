import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/dummy_loader.dart';
import '../utils/severity_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DummyLoader.load();

    return Scaffold(
      appBar: AppBar(title: const Text("Map View")),
      body: FlutterMap(
        options: MapOptions(
          center: data[0].location,
          zoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: data.map((d) => Marker(
              width: 20,
              height: 20,
              point: d.location,
              child: Icon(
                Icons.circle,
                color: getColorFromSeverity(d.severityScore),
                size: 12,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}