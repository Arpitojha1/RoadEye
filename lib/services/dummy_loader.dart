import '../models/distress_data.dart';
import '../services/shared_data.dart';

class DummyLoader {
  static List<DistressData> loadDummyData() {
    return [
      DistressData(
        startLat: 28.6139,
        startLon: 77.2090,
        roughness: 1200,
        rutting: 3.1,
        cracking: 0.011,
        ravelling: 0.006,
        region: "plains",
        severity: 0.568,
        lane: 'L1', // ✅ added
      ),
      DistressData(
        startLat: 28.6145,
        startLon: 77.2098,
        roughness: 1500,
        rutting: 3.8,
        cracking: 0.025,
        ravelling: 0.012,
        region: "plains",
        severity: 0.724,
        lane: 'L2', // ✅ added
      ),
    ];
  }

  static void loadIntoSharedData() {
    SharedData.instance.distressData = loadDummyData();
  }
}
