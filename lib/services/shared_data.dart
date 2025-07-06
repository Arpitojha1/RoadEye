import '../models/distress_data.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

class SharedData {
  static final SharedData _instance = SharedData._internal();
  
  List<DistressData> distressData = [];
  File? videoFile;          // For mobile/desktop
  Uint8List? videoBytes;    // For web

  factory SharedData() => _instance;
  SharedData._internal();

  static SharedData get instance => _instance;
}