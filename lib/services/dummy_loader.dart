import 'package:latlong2/latlong.dart';
import '../models/distress_data.dart';

class DummyLoader {
  static List<DistressData> load() {
    return [
      DistressData(
        roughness: 2000,
        rutting: 4.5,
        cracking: 0.3,
        location: LatLng(26.3456, 76.2487),
        severityScore: 0.75,
      ),
      DistressData(
        roughness: 1500,
        rutting: 2.1,
        cracking: 0.1,
        location: LatLng(26.3461, 76.2492),
        severityScore: 0.45,
      ),
    ];
  }
}
