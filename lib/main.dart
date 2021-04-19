import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

final QuickActions _quickActions = QuickActions();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red,
      body: Home(),
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() { 
    super.initState();
    _quickActions.initialize((type) { 
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('Test'),
      ));
    });
    _quickActions.setShortcutItems([
      ShortcutItem(type: 'test', localizedTitle: 'Test'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
