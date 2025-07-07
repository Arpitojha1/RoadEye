import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/shared_data.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'dart:convert' show base64Encode;

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (kIsWeb) {
        if (SharedData.instance.videoBytes != null) {
          _controller = VideoPlayerController.network(
            'data:video/mp4;base64,${base64Encode(SharedData.instance.videoBytes!)}'
          )..initialize().then((_) {
            setState(() => _isInitialized = true);
          });
        }
      } else {
        if (SharedData.instance.videoFile != null) {
          _controller = VideoPlayerController.file(SharedData.instance.videoFile!)
            ..initialize().then((_) {
              setState(() => _isInitialized = true);
            });
        }
      }
    } catch (e) {
      debugPrint('Video initialization error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Road Video')),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Text('No video available or still loading'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}