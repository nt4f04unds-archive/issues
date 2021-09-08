package com.example.flutter_89615

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
   override fun provideFlutterEngine(context: Context): FlutterEngine? {
      return MyApp.engine;
   }
}
