import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../services/excel_parser.dart';
import '../services/shared_data.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? excelFile;
  File? videoFile;
  String status = "No files selected yet.";

  Future<void> pickExcelFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (result != null && result.files.single.path != null) {
    final file = File(result.files.single.path!);
    final parsed = await ExcelParser.parse(file);  
    SharedData.parsedRoadData = parsed;           

    setState(() {
      excelFile = file;
      status = "Excel selected: ${result.files.single.name}";
    });
  }
  }

  Future<void> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        videoFile = File(path);
        status = "Video selected: ${result.files.single.name}";
      });

      SharedData.videoFilePath = path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload NSV Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: pickExcelFile,
              icon: Icon(Icons.upload_file),
              label: Text("Upload Excel (.xlsx)"),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pickVideoFile,
              icon: Icon(Icons.video_file),
              label: Text("Upload Video (.mp4)"),
            ),
            SizedBox(height: 24),
            Text(
              status,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            if (excelFile != null) Text("Excel Uploaded: ${excelFile!.path.split('/').last}"),
            if (videoFile != null) Text("Video Uploaded: ${videoFile!.path.split('/').last}"),
          ],
        ),
      ),
    );
  }
}
