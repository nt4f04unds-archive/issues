import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

MethodChannel channel;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  channel = const MethodChannel('channel');
  channel.setMethodCallHandler((MethodCall call) async {
    if (call.method == 'test') {

      // outputs `List<Object?>` (or `List<dynamic>` dependent on flutter version)
      print(call.arguments.runtimeType);

      // this invalid cast fails without any error
      List<String> variable = call.arguments as List<String>;

      void function(List<String> value) { }
      // this call will also fail code
      // function(call.arguments);

      // and any further instructions in this closure won't be executed
      print('print');
    }
  });
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
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
