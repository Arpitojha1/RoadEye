import '../models/distress_data.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:latlong2/latlong.dart';  // 👈 Required for LatLng

class SharedData {
  static final SharedData _instance = SharedData._internal();

  List<DistressData> distressData = [];
  List<LatLng> coordinates = [];  // ✅ This line fixes the setter error

  File? videoFile;          // For mobile/desktop
  Uint8List? videoBytes;    // For web

  factory SharedData() => _instance;
  SharedData._internal();

  static SharedData get instance => _instance;
}
