import 'dart:async';

import 'package:flutter/services.dart';

class Leveldb {
  static const MethodChannel _channel = MethodChannel('leveldb');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
