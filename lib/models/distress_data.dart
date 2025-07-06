// models/distress_data.dart
class DistressData {
  final double startLat;
  final double startLon;
  final double roughness;
  final double rutting;
  final double cracking;
  final double ravelling;
  final String region;
  final double severity;

  DistressData({
    required this.startLat,
    required this.startLon,
    required this.roughness,
    required this.rutting,
    required this.cracking,
    required this.ravelling,
    required this.region,
    required this.severity,
  });

  factory DistressData.fromJson(Map<String, dynamic> json) {
    return DistressData(
      startLat: json['startLat'] ?? 0.0,
      startLon: json['startLon'] ?? 0.0,
      roughness: json['roughness'] ?? 0.0,
      rutting: json['rutting'] ?? 0.0,
      cracking: json['cracking'] ?? 0.0,
      ravelling: json['ravelling'] ?? 0.0,
      region: json['region'] ?? 'plains',
      severity: json['severity'] ?? 0.0,
    );
  }
}