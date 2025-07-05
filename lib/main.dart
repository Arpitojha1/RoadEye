import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'screens/dashboard_screen.dart';

void main() => runApp(RoadEyeApp());

class RoadEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoadEye',
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('RoadEye'),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.map), text: "Map"),
              Tab(icon: Icon(Icons.analytics), text: "Dashboard"),
            ]),
          ),
          body: TabBarView(
            children: [
              MapScreen(),
              DashboardScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
