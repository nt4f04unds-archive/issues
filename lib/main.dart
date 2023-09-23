import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late VideoPlayerController controller;
  bool ready = false;
  double height = 100.0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    controller = VideoPlayerController.asset('assets/video60.mp4');
    await controller.initialize();
    controller.setLooping(true);
    controller.play();
    if (mounted)
      setState(() {
        ready = true;
      });
  }

  void _playPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ready
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: VideoPlayer(controller),
                    )
                  : SizedBox.shrink(),
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: _playPause,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
