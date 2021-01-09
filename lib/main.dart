import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: MaterialButton(
              child: Text('open delegate'),
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionsAndResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestionsAndResults(context);
  }

  final ItemScrollController controller = ItemScrollController();
  List<int> items = List<int>.generate(100, (index) => index);
  Widget _buildSuggestionsAndResults(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: controller,
      itemCount: items.length,
      itemBuilder: (context, index) => Text(index.toString()),
    );
  }
}
