import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../services/excel_parser.dart';
import '../services/shared_data.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _status = 'Select NSV Excel file';
  bool _isLoading = false;

  Future<void> _processExcel() async {
    setState(() {
      _isLoading = true;
      _status = 'Selecting Excel file...';
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final fileName = result.files.first.name;

        if (fileBytes != null) {
          setState(() => _status = 'Processing data...');
          final data = await ExcelParser.parseExcelBytes(fileBytes, fileName);
          SharedData.instance.distressData = data;
          setState(() => _status = '✅ Processed ${data.length} road segments');
        }
      } else {
        setState(() => _status = '❌ File selection cancelled');
      }
    } catch (e) {
      setState(() => _status = '❌ Error: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _processVideo() async {
  setState(() {
    _isLoading = true;
    _status = 'Selecting video file...';
  });

  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: false, // 🚫 prevent loading full video into memory
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;

      if (path != null) {
        SharedData.instance.videoFile = File(path);  // ✅ Just store reference
        setState(() => _status = '🎥 Large video file selected');
      } else {
        setState(() => _status = '❌ Could not read file path');
      }
    } else {
      setState(() => _status = '❌ Video selection cancelled');
    }
  } catch (e) {
    setState(() => _status = '❌ Error: ${e.toString()}');
  } finally {
    setState(() => _isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload NSV Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _processExcel,
              child: const Text('📊 Upload Excel File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _processVideo,
              child: const Text('🎥 Upload Video File'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              _status,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
