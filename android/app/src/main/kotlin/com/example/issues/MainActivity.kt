package com.example.flutter_93612

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    var engine: FlutterEngine? = null
    lateinit var channel: MethodChannel

    override fun provideFlutterEngine(context: Context): FlutterEngine {
        if (engine != null) return engine!!
        engine = FlutterEngine(this)
        engine!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        return engine!!
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "test")
        channel.setMethodCallHandler { call, result ->
            Executors.newSingleThreadExecutor().execute {
                val res = invokeMethod(call.method, null)
                result.success(res)
            }
        }
    }

    fun invokeMethod(method: String, arguments: Any?): Any? {
        println(method + " INVOKE")
        val deferred = CompletableDeferred<Any?>()
        CoroutineScope(Dispatchers.Main).launch {
            channel.invokeMethod(method, arguments, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    deferred.complete(result)
                }

                override fun error(code: String?, msg: String?, details: Any?) {
                    deferred.complete(null)
                }

                override fun notImplemented() {
                    deferred.complete(null)
                }
            })
        }
        return runBlocking {
            val res = deferred.await()
            println(method + " INVOKE RETURNED")
            return@runBlocking res
        }
    }
}
