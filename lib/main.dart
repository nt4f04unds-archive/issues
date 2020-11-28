import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectableText with AlwaysScrollableScrollPhysics',
      localizationsDelegates: [],
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SelectableText(
          List.generate(1000, (index) => index.toString()).join(" "),
          scrollPhysics: AlwaysScrollableScrollPhysics(),
          // or
          // scrollPhysics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          // or
          // scrollPhysics: ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          // or
          // scrollPhysics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          // or
          // scrollPhysics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          // or ...
        ),
      ),
    );
  }
}
