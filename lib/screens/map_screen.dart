import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import '../models/distress_data.dart';
import '../services/shared_data.dart';
import '../utils/severity_colors.dart';

class MapScreen extends StatefulWidget {
  final double? lat;
  final double? lon;

  const MapScreen({super.key, this.lat, this.lon});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? _selectedMarker;

  @override
  Widget build(BuildContext context) {
    final distressData = SharedData.instance.distressData;

    final defaultCenter = widget.lat != null && widget.lon != null
        ? latlong.LatLng(widget.lat!, widget.lon!)
        : (distressData.isNotEmpty
            ? latlong.LatLng(
                distressData.first.startLat, distressData.first.startLon)
            : const latlong.LatLng(28.6139, 77.2090));

    final markers = distressData.map((data) {
      final severityColor = SeverityCalculator.getSeverityColor(data.severity);
      return Marker(
        point: latlong.LatLng(data.startLat, data.startLon),
        width: 24,  // Smaller marker size
        height: 24, // Smaller marker size
        child: GestureDetector(
          onTap: () => setState(() {
            _selectedMarker = Marker(
              point: latlong.LatLng(data.startLat, data.startLon),
              width: 24,
              height: 24,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: severityColor,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            );
          }),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: severityColor,
              border: Border.all(color: Colors.white, width: 1),
              boxShadow: [
                BoxShadow(
                  color: severityColor.withAlpha((0.6 * 255).round()),
                  blurRadius: 4,  // Reduced shadow
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("RoadEye Map View"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: defaultCenter,
              zoom: 15.0,  // Slightly zoomed out
              onTap: (_, __) => setState(() => _selectedMarker = null),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          if (_selectedMarker != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _buildPopupCard(_selectedMarker!, distressData),
            ),
        ],
      ),
    );
  }

  Widget _buildPopupCard(Marker marker, List<DistressData> distressData) {
    final data = distressData.firstWhere(
      (d) => d.startLat == marker.point.latitude && 
             d.startLon == marker.point.longitude,
    );

    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPopupRow('Location', '${data.startLat.toStringAsFixed(4)}, ${data.startLon.toStringAsFixed(4)}'),
            _buildPopupRow('Severity', '${(data.severity * 100).toStringAsFixed(1)}%'),
            _buildPopupRow('Lane', data.lane.toString()),
            _buildPopupRow('Region', data.region.toString()),
            _buildPopupRow('Roughness', '${data.roughness} mm/km'),
            _buildPopupRow('Rutting', '${data.rutting} mm'),
            _buildPopupRow('Cracking', '${data.cracking}%'),
            _buildPopupRow('Ravelling', '${data.ravelling}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}