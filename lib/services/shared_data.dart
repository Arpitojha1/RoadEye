// services/shared_data.dart
import '../models/distress_data.dart';

class SharedData {
  static final SharedData _instance = SharedData._internal();
  List<DistressData> distressData = [];

  factory SharedData() {
    return _instance;
  }

  SharedData._internal();

  static SharedData get instance => _instance;
}