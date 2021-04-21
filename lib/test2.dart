import 'package:firebase_messaging/firebase_messaging.dart';

abstract class Test2 {
  static Future<void> foregroundMessageHandler(RemoteMessage message) async {}
  static Future<void> backgroundMessageHandler(RemoteMessage message) async { }
}