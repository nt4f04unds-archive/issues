import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    MaterialApp(
      home: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _Video(),
      ),
    );
  }
}


class _Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<_Video> {
  VideoPlayerController? _controller;

  Future<void> _startPlayer() async {
    if (_controller != null)
      return;
    _controller = VideoPlayerController.asset('assets/video.mp4');
    _controller!.setLooping(true);
    await _controller!.initialize();
    if (mounted) {
      setState(() {
        _controller!.play();
      });
    }
  }

  Future<void> _disposePlayer() async {
    if (_controller == null)
      return;
    final oldController = _controller;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      oldController!.dispose();
    });
    setState(() {
      _controller = null;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_controller == null) {
      _startPlayer();
    } else {
      _disposePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_controller == null ? Icons.play_arrow : Icons.pause),
              onPressed: _handleTap,
            ),
          ],
        ),
        if (_controller != null)
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller!),
                  VideoProgressIndicator(_controller!, allowScrubbing: true),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
