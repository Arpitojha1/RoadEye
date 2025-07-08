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

  factory DistressData.fromJson(Map<String, dynamic> json) {
  return DistressData(
    lane: json['lane'],
    startLat: json['startLat'],
    startLon: json['startLon'],
    roughness: json['roughness'],
    rutting: json['rutting'],
    cracking: json['cracking'],
    ravelling: json['ravelling'],
    region: json['region'],
    severity: json['severity'],
  );
}
}
