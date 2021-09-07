package com.example.flutter_89615

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        engine = FlutterEngine(this)
        engine!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        FlutterEngineCache.getInstance().put("myengine", engine)
    }

    companion object {
        var engine: FlutterEngine? = null
    }
}