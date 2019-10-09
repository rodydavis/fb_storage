import 'dart:async';

import 'package:flutter/services.dart';

class FbStorage {
  static const MethodChannel _channel =
      const MethodChannel('fb_storage');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
