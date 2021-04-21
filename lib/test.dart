
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_80704/test2.dart';

class Test {
  Test._();
  static final instance = Test._();

  void init() {
    FirebaseMessaging.onMessage.listen(
      Test2.foregroundMessageHandler,
    );
    FirebaseMessaging.onBackgroundMessage(
      Test2.foregroundMessageHandler,
    );
  }
}

