import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final ItemScrollController controller = ItemScrollController();
  final List<int> items = List<int>.generate(100, (index) => index);
  Widget _buildListView(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: controller,
      itemCount: items.length,
      itemBuilder: (context, index) => Text(index.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Builder(
        builder: (context) => Scaffold(
          body: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: TabBarView(
              children: [
                _buildListView(context),
                _buildListView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
