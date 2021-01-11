import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
  SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        body: const Center(
          child: Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
