import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/video_screen.dart'; 
import 'screens/upload_screen.dart';
void main() => runApp(RoadEyeApp());

class RoadEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoadEye',
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 4, //changed from 2 to 4
        child: Scaffold(
          appBar: AppBar(
            title: Text('RoadEye'),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.map), text: "Map"),
              Tab(icon: Icon(Icons.analytics), text: "Dashboard"),
              Tab(icon: Icon(Icons.video_library), text: "Video"),
              Tab(icon: Icon(Icons.upload), text: "Upload"),
            ]),
          ),
          body: TabBarView(
            children: [
              MapScreen(),
              DashboardScreen(),
              VideoScreen(), 
              UploadScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
