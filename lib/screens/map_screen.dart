// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import '../models/distress_data.dart';
import '../services/shared_data.dart';
import '../utils/severity_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final distressData = SharedData.instance.distressData;
    
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: distressData.isNotEmpty 
              ? latlong.LatLng(
                  distressData.first.startLat,
                  distressData.first.startLon,
                )
              : const latlong.LatLng(28.6139, 77.2090),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: distressData.map((data) {
              return Marker(
                point: latlong.LatLng(data.startLat, data.startLon),
                width: 40,
                height: 40,
                child: Icon(
                  Icons.location_on,
                  color: SeverityCalculator.getSeverityColor(data.severity),
                  size: 40,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}