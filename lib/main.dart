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
    controller = VideoPlayerController.asset('assets/video60_broken.mp4');
    await controller.initialize();
    controller.setLooping(true);
    controller.play();
    if (mounted)
      setState(() {
        ready = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Stack(
          children: [
            ready
                ? SizedBox(
                    height: height,
                    child: VideoPlayer(controller),
                  )
                : SizedBox.shrink(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text('switch height'),
                onPressed: () {
                  if (height == 100.0) {
                    height = 700.0;
                  } else {
                    height = 100.0;
                  }
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
