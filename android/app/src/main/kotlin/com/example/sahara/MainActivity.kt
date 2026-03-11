package com.example.sahara

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen
import android.os.Bundle

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Remove the status bar to make it fullscreen during launch
        super.onCreate(savedInstanceState)
    }

    override fun provideSplashScreen(): SplashScreen? {
        // Return null to skip Flutter's default splash screen
        // Your custom splash screen will show immediately
        return null
    }
}
