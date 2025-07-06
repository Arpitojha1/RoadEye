import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/shared_data.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Select video source: uploaded or fallback asset
    if (SharedData.videoFilePath != null) {
      _controller = VideoPlayerController.file(File(SharedData.videoFilePath!));
    } else {
      _controller = VideoPlayerController.asset('assets/videos/nsv_sample.mp4');
    }

    _controller.initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
      _controller.play(); // Autoplay
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NSV Video Playback")),
      body: Center(
        child: _isInitialized
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    SizedBox(height: 10),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            if (SharedData.videoFilePath != null) {
                               _controller.pause();
                               _controller.dispose();
                               _controller = VideoPlayerController.file(File(SharedData.videoFilePath!))
                              ..initialize().then((_) {
                                setState(() {});
                                _controller.play();
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
