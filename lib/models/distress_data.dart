class DistressData {
  final double startLat;
  final double startLon;
  final double roughness;
  final double rutting;
  final double cracking;
  final double ravelling;
  final String region;
  final double severity;
  final String lane; // 👈 NEW: to distinguish L1, L2, etc.

  DistressData({
    required this.startLat,
    required this.startLon,
    required this.roughness,
    required this.rutting,
    required this.cracking,
    required this.ravelling,
    required this.region,
    required this.severity,
    required this.lane,
  });

  Map<String, dynamic> toJson() => {
        'startLat': startLat,
        'startLon': startLon,
        'roughness': roughness,
        'rutting': rutting,
        'cracking': cracking,
        'ravelling': ravelling,
        'region': region,
        'severity': severity,
        'lane': lane,
      };

  factory DistressData.fromJson(Map<String, dynamic> json) => DistressData(
        startLat: json['startLat']?.toDouble() ?? 0.0,
        startLon: json['startLon']?.toDouble() ?? 0.0,
        roughness: json['roughness']?.toDouble() ?? 0.0,
        rutting: json['rutting']?.toDouble() ?? 0.0,
        cracking: json['cracking']?.toDouble() ?? 0.0,
        ravelling: json['ravelling']?.toDouble() ?? 0.0,
        region: json['region'] ?? 'plains',
        severity: json['severity']?.toDouble() ?? 0.0,
        lane: json['lane'] ?? 'L1',
      );
}
