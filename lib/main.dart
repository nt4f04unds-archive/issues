import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('test');
  await channel.invokeMethod('1');
  await channel.invokeMethod('2');
  await channel.invokeMethod('3');
  await channel.invokeMethod('4');
  await channel.invokeMethod('5');
  runApp(Container(color: Colors.red));
}
