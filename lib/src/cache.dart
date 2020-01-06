import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:leveldb/src/library.dart';
import 'package:leveldb/src/native_wrapper.dart';

abstract class Cache extends NativeWrapper {
  /// Create a new cache with a fixed size capacity.  This implementation
  /// of Cache uses a least-recently-used eviction policy.
  factory Cache.lru(int capacity) => _Cache(Lib.levelDB, capacity);
}

class _Cache implements Cache {
  final LibLevelDB lib;

  @override
  bool get isDisposed => ptr == null || ptr == nullptr;

  @override
  Pointer<leveldb_cache_t> ptr;

  _Cache(
    this.lib,
    int capacity,
  ) : ptr = lib.leveldbCacheCreateLru(capacity);

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbCacheDestroy(ptr);
    ptr = nullptr;
  }
}
