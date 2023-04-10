package com.github.rnovoselov.weather

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("ffe97413-1ca8-4261-82b1-20699f5206e5") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
