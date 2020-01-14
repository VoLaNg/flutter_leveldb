import 'dart:typed_data';

import 'dart:math' as math show Random;
import 'package:leveldb/leveldb.dart';
// import 'package:flutter_driver/flutter_driver.dart';

// extension PathProvider on FlutterDriver {
//   static const tempDirCommand = 'path_provider.getTemporaryDirectory()';

//   Future<String> getTempDir() {
//     return requestData(tempDirCommand);
//   }
// }

extension ConvenienceLevelDB on LevelDB {
  void putAllAndDispose(
    List<KeyValue<RawData, RawData>> kvList, {
    bool ensured = false,
  }) {
    for (var kv in kvList) {
      put(kv.key, kv.value, ensured: ensured);
      kv.dispose();
    }
  }

  void putAllStrings(Map<String, String> kvStrings, {bool ensured = false}) {
    putAllAndDispose(
        kvStrings.entries.map((kv) {
          return KeyValue(
            RawData.fromList(Uint8List.fromList(kv.key.codeUnits)),
            RawData.fromList(Uint8List.fromList(kv.value.codeUnits)),
          );
        }).toList(),
        ensured: ensured);
  }

  void deleteAllStringKeys(List<String> keys, {bool ensured = false}) {
    for (var k in keys) {
      final byteKey = RawData.fromList(Uint8List.fromList(k.codeUnits));
      delete(byteKey, ensured: ensured);
      byteKey.dispose();
    }
  }
}

extension RandomMap on Map<String, String> {
  static Map<String, String> random(int count, int length) {
    if (count == 0) return {};
    assert(count > 0);

    final rnd = math.Random();
    final keys = List<String>.generate(
      count,
      (i) => RandomString.random(length, rnd),
    );
    final values = List<String>.generate(
      count,
      (i) => RandomString.random(length, rnd),
    );
    return Map.fromIterables(keys, values);
  }
}

extension RandomString on String {
  static String random(int length, math.Random rnd) {
    return String.fromCharCodes(
        List<int>.generate(length, (i) => rnd.nextInt(16)));
  }
}
