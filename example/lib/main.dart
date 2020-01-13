// import 'dart:io';
import 'dart:typed_data';

// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:leveldb/leveldb.dart';

void main() async {
  runApp(Container(color: Colors.purple));

  // WARNING: Do not use temp directory as database location
  // Directory tempDir = await getTemporaryDirectory();
  // String tempPath = tempDir.path;
  // tempPath = path.join(tempPath, 'test2.leveldb');

  // openPutClose(tempPath, Options.byDefault(createIfMissing: true));
  // openGetClose(tempPath, Options.byDefault(createIfMissing: true));

  // final db = LevelDB.open(
  //   options: Options.byDefault(createIfMissing: true),
  //   filePath: tempPath,
  // );

  // db.close();
}

void openPutClose(String filePath, Options options) {
  final db = LevelDB.open(
    options: options,
    filePath: filePath,
  );

  final key = Uint8List.fromList('fooKey'.codeUnits);
  final value = Uint8List.fromList('barValue'.codeUnits);

  void put() {
    final k = RawData.fromList(key);
    final v = RawData.fromList(value);
    db.put(k, v, ensured: true);
    k.dispose();
    v.dispose();
  }

  put();
  db.close();
}

void openGetClose(String filePath, Options options) {
  final db = LevelDB.open(
    options: options,
    filePath: filePath,
  );

  final key = Uint8List.fromList('fooKey'.codeUnits);

  String get() {
    final k = RawData.fromList(key);
    final v = db.get(k);
    final result = String.fromCharCodes(v.bytes);
    k.dispose();
    v.dispose();
    return result;
  }

  final str = get();
  print(str);

  db.close();
}
