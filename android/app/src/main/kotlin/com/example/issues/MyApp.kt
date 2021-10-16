package com.example.flutter_91950

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()

        // This line causes a bug
        FlutterEngine(this)
    }
}