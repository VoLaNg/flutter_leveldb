import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:leveldb/leveldb.dart';

void main() async {
  runApp(Container());

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  tempPath = path.join(tempPath, 'test.leveldb');

  final db = LevelDB.open(
    options: Options.byDefault(createIfMissing: true),
    name: tempPath,
  );

  final key = Uint8List.fromList('example'.codeUnits);
  final value = Uint8List.fromList('world'.codeUnits);

  void put() {
    final k = RawData.fromList(key);
    final v = RawData.fromList(value);
    db.put(k, v, ensured: true);
    k.dispose();
    v.dispose();
  }

  String get() {
    final k = RawData.fromList(key);
    final v = db.get(k);
    final result = String.fromCharCodes(v.bytes);
    k.dispose();
    v.dispose();
    return result;
  }

  put();
  final str = get();
  print(str);
}
