import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<int> items = List<int>.generate(100, (index) => index);

  bool animate = false;
  final ScrollController scrollController = ScrollController();
  Widget _buildListView() {
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) => Text(index.toString()),
    );
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemScrollController itemScrollController2 = ItemScrollController();

  Widget _buildScrollablePositionedList([ItemScrollController controller]) {
    return ScrollablePositionedList.builder(
      itemScrollController: controller ?? itemScrollController,
      itemCount: items.length,
      itemBuilder: (context, index) => Text(index.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Partition(
                title: 'ListView',
                actions: [
                  CheckboxListTile(
                    tileColor: Colors.white,
                    title: const Text('animate'),
                    value: animate,
                    onChanged: (_) {
                      animate = !animate;
                      setState(() {});
                    },
                  ),
                  MaterialButton(
                    child: const Text('scrollTo top'),
                    color: Colors.white,
                    onPressed: () {
                      if (animate)
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic,
                        );
                      else
                        scrollController.jumpTo(0);
                    },
                  ),
                  MaterialButton(
                    child: const Text('scrollTo end'),
                    color: Colors.white,
                    onPressed: () {
                      if (animate)
                        scrollController.animateTo(
                          1000,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic,
                        );
                      else
                        scrollController.jumpTo(1000);
                    },
                  ),
                ],
                children: [
                  _buildListView(),
                  _buildListView(),
                ],
                colors: [Colors.blue, Colors.red],
              ),
              Partition(
                title: 'ScrollablePositionedList',
                actions: [],
                children: [
                  _buildScrollablePositionedList(),
                  _buildScrollablePositionedList(
                    itemScrollController,
                  ),
                ],
                colors: [Colors.yellow, Colors.green],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Partition extends StatelessWidget {
  const Partition({
    Key key,
    @required this.title,
    @required this.children,
    @required this.actions,
    @required this.colors,
  })  : assert(children.length == colors.length),
        super(key: key);
  final String title;
  final List<Widget> children;
  final List<Widget> actions;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: colors[0],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: children
                  .asMap()
                  .entries
                  .map(
                    (e) => Expanded(
                      child: Container(
                        width: double.infinity,
                        color: colors[e.key],
                        child: e.value,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                ...actions,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
