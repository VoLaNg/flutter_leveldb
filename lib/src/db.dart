import 'dart:ffi';
import 'package:ffi/ffi.dart' hide allocate;
import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart';

import 'library.dart';
import 'options.dart';
import 'utils.dart';

abstract class LevelDB {
  /// Open the database with the specified "name".
  factory LevelDB.open({
    @required Options options,
    @required String name,
  }) =>
      _LevelDB(
        options: options,
        name: name,
        lib: Lib.levelDB,
      );
}

class _LevelDB implements LevelDB {
  final LibLevelDB lib;
  final Pointer<leveldb_t> dbptr;
  final Options options;

  _LevelDB({
    @required this.options,
    @required String name,
    @required this.lib,
  }) : dbptr = open(options, name, lib);

  static Pointer<leveldb_t> open(
    Options options,
    String name,
    LibLevelDB lib,
  ) {
    assert(
      options != null,
      'LevelDB.open: Name parameter is required',
    );
    assert(
      name?.isNotEmpty ?? false,
      'LevelDB.open: Name parameter is required',
    );
    return allocctx((Pointer<Utf8> strptr) {
      return errorHandler(
        // ignore: invalid_use_of_protected_member
        (errptr) => lib.leveldbOpen(options.ptr, strptr, errptr),
      );
    }, () => Utf8.toUtf8(name));
  }
}
