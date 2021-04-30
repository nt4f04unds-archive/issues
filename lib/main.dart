import 'dart:math';

import 'package:flutter/material.dart';

const int _mask = 0x1a;
Color getColorForBlend(Color color) {
  final int r = (((color.value >> 16) & 0xff) - _mask).clamp(0, 0xff);
  final int g = (((color.value >> 8) & 0xff) - _mask).clamp(0, 0xff);
  final int b = ((color.value & 0xff) - _mask).clamp(0, 0xff);
  return Color((0xff << 24) + (r << 16) + (g << 8) + b);
}

void main() {
  runApp(App());
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> data;
  final random = Random();

  @override
  void initState() { 
    super.initState();
    data = List.generate(1000, (index) => index.toString() * (1 + random.nextInt(4)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Art(),
          title: Text(data[index]),
        );
      },
    );
  }
}

class Art extends StatefulWidget {
  Art({Key key}) : super(key: key);

  @override
  _ArtState createState() => _ArtState();
}

class _ArtState extends State<Art> {
  static const size = 48.0;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheSize = (size * devicePixelRatio).round();
    return Image.asset(
      'assets/art_mask.png',
      width: size,
      height: size,
      cacheWidth: cacheSize,
      cacheHeight: cacheSize,
      color: getColorForBlend(Colors.deepPurpleAccent),
      colorBlendMode: BlendMode.plus,
      fit: BoxFit.cover,
    );
  }
}