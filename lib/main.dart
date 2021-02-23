import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final int itemCount = 1000000000000;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: 160.0,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, idx) {
                return Container(
                  width: 40,
                  height: 40, 
                  color: Colors.red,
                  margin: EdgeInsets.all(8.0),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}