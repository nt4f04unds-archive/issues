package com.example.flutter_40523

import android.app.Activity
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneralChannel.instance.init(getFlutterView())
    }

    private fun getFlutterView(): BinaryMessenger? {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }
}

enum class GeneralChannel {
    instance;
    open fun init(messenger: BinaryMessenger?) {
        if (channel == null) {
            channel = MethodChannel(messenger, "channel")
            channel!!.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result -> onMethodCall(call, result) }
        }
    }
    open fun kill() {
        channel = null
    }
    private var channel: MethodChannel? = null
    open fun send() {
        channel!!.invokeMethod("test", ArrayList<String>())
    }
    open fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        send();
        result.success(true)
    }
}
