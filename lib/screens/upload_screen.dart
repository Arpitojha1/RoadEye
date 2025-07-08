import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../models/distress_data.dart';
import '../services/shared_data.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _status = '📂 Select NSV JSON file';
  bool _isLoading = false;

  Future<void> _processJson() async {
    setState(() {
      _isLoading = true;
      _status = '📂 Selecting JSON file...';
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final fileName = result.files.first.name;

        if (fileBytes != null) {
          setState(() => _status = '⚙️ Parsing "$fileName"...');

          final jsonString = utf8.decode(fileBytes);
          final jsonData = json.decode(jsonString) as List;

          final distressData = jsonData.map((e) => DistressData.fromJson(e)).toList();
          SharedData.instance.distressData = distressData;

          if (distressData.isEmpty) {
            setState(() => _status = '⚠️ No data found in "$fileName".');
          } else {
            setState(() => _status = '✅ Parsed ${distressData.length} segments from "$fileName".');
          }
        } else {
          setState(() => _status = '❌ File was empty or unreadable.');
        }
      } else {
        setState(() => _status = '❌ File selection cancelled');
      }
    } catch (e) {
      setState(() => _status = '❌ Error parsing JSON: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _processVideo() async {
    setState(() {
      _isLoading = true;
      _status = '📂 Selecting video file...';
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        withData: kIsWeb, // ✅ Load bytes only on web
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (kIsWeb) {
          SharedData.instance.videoBytes = file.bytes;
          setState(() => _status = '🎥 Video uploaded (web): ${file.name}');
        } else {
          if (file.path != null) {
            SharedData.instance.videoFile = File(file.path!);
            setState(() => _status = '🎥 Video selected: ${file.name}');
          } else {
            setState(() => _status = '❌ Could not read video file path.');
          }
        }
      } else {
        setState(() => _status = '❌ Video selection cancelled');
      }
    } catch (e) {
      setState(() => _status = '❌ Error loading video: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload NSV JSON + Video')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _processJson,
              child: const Text('📄 Upload NSV JSON File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _processVideo,
              child: const Text('🎥 Upload Video File'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
