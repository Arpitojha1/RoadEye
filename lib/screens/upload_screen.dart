import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
      setState(() {
        excelFile = File(result.files.single.path!);
        status = "Excel selected: ${result.files.single.name}";
      });
    }
  }

  Future<void> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        videoFile = File(result.files.single.path!);
        status = "Video selected: ${result.files.single.name}";
      });
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
            Text(status, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
