import 'package:flutter/material.dart';
import '../models/distress_data.dart';
import '../utils/severity_colors.dart';
import '../screens/map_screen.dart'; // Make sure this path is correct

class SeverityTile extends StatefulWidget {
  final DistressData data;

  const SeverityTile({Key? key, required this.data}) : super(key: key);

  @override
  State<SeverityTile> createState() => _SeverityTileState();
}

class _SeverityTileState extends State<SeverityTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final severityColor =
        SeverityCalculator.getSeverityColor(widget.data.severity);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Basic Info Always Visible
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: severityColor,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lat: ${widget.data.startLat.toStringAsFixed(4)}, Lon: ${widget.data.startLon.toStringAsFixed(4)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'Severity: ${widget.data.severity.toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),

              /// Expandable Details
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Colors.grey.shade300),
                      Text('Lane: ${widget.data.lane}'),
                      Text('Roughness: ${widget.data.roughness} mm/km'),
                      Text('Rutting: ${widget.data.rutting} mm'),
                      Text('Cracking: ${widget.data.cracking}%'),
                      Text('Ravelling: ${widget.data.ravelling}%'),
                      Text('Region: ${widget.data.region}'),

                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapScreen(
                                lat: widget.data.startLat,
                                lon: widget.data.startLon,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.map),
                        label: const Text("View on Map"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
