package com.potatoproject.notes;

import android.os.Bundle;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.content.res.Configuration;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), "potato_notes_utils").setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if(call.method.equals("getAccentColor")) {
            result.success(getAccentColor());
          } else {
            result.notImplemented();
          }
        }
      }
    );
  }

  private int getAccentColor() {
    String colResName = "accent_device_default_dark";
    Resources res = null;
    try {
      res = this.getPackageManager().getResourcesForApplication("android");
      int resId = res.getIdentifier("android:color/" + colResName, null, null);
      try {
        return res.getColor(resId);
      } catch (Resources.NotFoundException e) {
        return 0xFF80CBC4;
      }
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    return 0;
  }
}
