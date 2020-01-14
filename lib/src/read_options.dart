import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart' show protected, visibleForTesting;

import 'constants.dart';
import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';
import 'snapshot.dart';

abstract class ReadOptions extends AnyStructure {
  static final _ReadOptions defaultOptions = _ReadOptions(Lib.levelDB);

  bool get isDefault;
  bool get verifyChecksums;
  bool get fillCache;
  Snapshot get snapshot;

  factory ReadOptions({
    bool verifyChecksums = _verifyChecksumDefault,
    bool fillCache = _fillCacheDefault,
    Snapshot snapshot,
    @visibleForTesting LibLevelDB lib,
  }) =>
      _ReadOptions(
        lib ?? Lib.levelDB,
        verifyChecksums: verifyChecksums,
        fillCache: fillCache,
        snapshot: snapshot,
      );

  static const _verifyChecksumDefault = false;
  static const _fillCacheDefault = true;

  @protected
  static bool isEqualToDefault({
    bool verifyChecksums = _verifyChecksumDefault,
    bool fillCache = _fillCacheDefault,
    Snapshot snapshot,
  }) =>
      verifyChecksums == ReadOptions._verifyChecksumDefault &&
      fillCache == ReadOptions._fillCacheDefault &&
      (snapshot == null || snapshot.isDisposed);

  bool operator ==(Object o);
}

class _ReadOptions implements ReadOptions {
  final LibLevelDB lib;
  final bool verifyChecksums;
  final bool fillCache;
  final Snapshot snapshot;

  @override
  Pointer<leveldb_readoptions_t> ptr;

  @override
  bool get isDefault => ReadOptions.isEqualToDefault(
        verifyChecksums: verifyChecksums,
        fillCache: fillCache,
        snapshot: snapshot,
      );

  _ReadOptions(
    this.lib, {
    this.verifyChecksums = ReadOptions._verifyChecksumDefault,
    this.fillCache = ReadOptions._fillCacheDefault,
    this.snapshot,
  }) : ptr = _setup(
          lib,
          verifyChecksums: verifyChecksums,
          fillCache: fillCache,
          snapshot: snapshot,
        );

  static Pointer<leveldb_readoptions_t> _setup(
    LibLevelDB lib, {
    bool verifyChecksums,
    bool fillCache,
    Snapshot snapshot,
  }) {
    final ptr = lib.leveldbReadoptionsCreate();
    lib.leveldbReadoptionsSetFillCache(ptr, fillCache.toInt());
    lib.leveldbReadoptionsSetVerifyChecksums(ptr, verifyChecksums.toInt());
    if (snapshot == null || snapshot.isDisposed) {
      lib.leveldbReadoptionsSetSnapshot(ptr, nullptr);
    } else {
      lib.leveldbReadoptionsSetSnapshot(ptr, snapshot.ptr);
    }
    return ptr;
  }

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbReadoptionsDestroy(ptr);
    ptr == nullptr;
    if (!kReleaseMode && (snapshot?.isDisposed ?? false)) {
      print(
        "Friendly reminder from [ReadOptions.dispose]: "
        "don't forget to dispose [Snapshot]",
      );
    }
  }

  @override
  String toString() {
    return '_ReadOptions verifyChecksums: $verifyChecksums, fillCache: $fillCache, snapshot: $snapshot, ptr: $ptr';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is _ReadOptions &&
        o.lib == lib &&
        o.verifyChecksums == verifyChecksums &&
        o.fillCache == fillCache &&
        o.snapshot == snapshot &&
        o.ptr == ptr;
  }

  @override
  int get hashCode {
    return lib.hashCode ^
        verifyChecksums.hashCode ^
        fillCache.hashCode ^
        snapshot.hashCode ^
        ptr.hashCode;
  }
}
