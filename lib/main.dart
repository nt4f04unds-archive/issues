import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

MethodChannel channel;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  channel = const MethodChannel('channel');
  channel.setMethodCallHandler((MethodCall call) async {
    if (call.method == "test") {

      // Outputs type `List<dynamic>`
      debugPrint(call.arguments.runtimeType.toString());

      // This fails without ANY ERROR
      List<String> testVar = call.arguments as List<String>;

      // This call will also fail code
      // _getSongsFromChannel(call.arguments);

      // And any further instructions in this closure won't be executed
      debugPrint('wfqfwqfq');
    }
  });
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            channel.invokeMethod('');
          },
        ),
      ),
    );
  }
}
