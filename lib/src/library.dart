import 'dart:ffi';
import 'dart:io';

import 'package:leveldb/interop/interop.dart' show LibLevelDB;

abstract class Lib {
  /// lazy static var
  static final LibLevelDB levelDB = LibLevelDB.lookupLib(_load('leveldb'));

  static DynamicLibrary _load(String name) {
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    }
    if (Platform.isAndroid) {
      return DynamicLibrary.open('lib$name.so');
    }
    throw UnsupportedError(
      'Currently LevelDB supports only iOS, MacOS and Android platforms',
    );
  }
}
