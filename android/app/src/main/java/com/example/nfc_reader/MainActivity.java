package com.example.nfc_reader;

import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "hce.channel";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("setData")) {
                        String data = call.argument("data");
                        if (data == null || data.isEmpty()) data = "1234567a";

                        // Make sure MyHostApduService is imported and in same package
                        MyHostApduService.virtualData = data;

                        result.success(true);
                    } else {
                        result.notImplemented();
                    }
                });
    }
}
