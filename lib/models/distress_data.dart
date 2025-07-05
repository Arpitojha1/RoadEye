import 'package:latlong2/latlong.dart';

class DistressData {
  final double roughness;
  final double rutting;
  final double cracking;
  final LatLng location;
  final double severityScore;

  DistressData({
    required this.roughness,
    required this.rutting,
    required this.cracking,
    required this.location,
    required this.severityScore,
  });
}
