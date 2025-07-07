import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:latlong2/latlong.dart';

import '../services/excel_parser.dart';
import '../services/shared_data.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _status = 'Select a file';
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

      if (result != null) {
        setState(() => _status = 'Processing data...');

        final fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          final coordinates = await ExcelParser.parseExcelBytes(fileBytes);
          SharedData.instance.coordinates = coordinates;

          setState(() {
            _status = 'Processed ${coordinates.length} coordinate points';
          });
        } else {
          setState(() => _status = 'File read failed');
        }
      } else {
        setState(() => _status = 'File selection cancelled');
      }
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
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
      );

      if (result != null) {
        if (kIsWeb) {
          SharedData.instance.videoBytes = result.files.single.bytes;
        } else {
          SharedData.instance.videoFile = File(result.files.single.path!);
        }

        setState(() => _status = 'Video file ready');
      } else {
        setState(() => _status = 'Video selection cancelled');
      }
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _processExcel,
              child: const Text('Upload Excel File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _processVideo,
              child: const Text('Upload Video File'),
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