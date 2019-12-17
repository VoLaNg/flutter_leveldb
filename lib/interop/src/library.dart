import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'leveldb_options_t.dart';
import 'leveldb_t.dart';

abstract class LibLevelDB {
  factory LibLevelDB.lookupLib(DynamicLibrary lib) => _LibLevelDB(lib);
  // ?: factory LibLevelDB.lazyLookupLib(DynamicLibrary lib) => _LazyLibLevelDB(lib);
}

class _LibLevelDB implements LibLevelDB {
  final DynamicLibrary lib;

  final Leveldb_open leveldbOpen;
  final Leveldb_close leveldbClose;
  final Leveldb_put leveldbPut;
  final Leveldb_delete leveldbDelete;
  final Leveldb_write leveldbWrite;
  final Leveldb_get leveldbGet;

  _LibLevelDB(this.lib)
      : leveldbOpen = lib
            .lookup<NativeFunction<leveldb_open>>('leveldb_open')
            .asFunction(),
        leveldbClose = lib
            .lookup<NativeFunction<leveldb_close>>('leveldb_close')
            .asFunction(),
        leveldbPut =
            lib.lookup<NativeFunction<leveldb_put>>('leveldb_put').asFunction(),
        leveldbDelete = lib
            .lookup<NativeFunction<leveldb_delete>>('leveldb_delete')
            .asFunction(),
        leveldbWrite = lib
            .lookup<NativeFunction<leveldb_write>>('leveldb_write')
            .asFunction(),
        leveldbGet =
            lib.lookup<NativeFunction<leveldb_get>>('leveldb_get').asFunction();
}
