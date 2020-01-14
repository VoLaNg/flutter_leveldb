import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart';
import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';

abstract class Cache extends AnyStructure {
  /// Create a new cache with a fixed size capacity.  This implementation
  /// of Cache uses a least-recently-used eviction policy.
  factory Cache.lru(int capacity, [@visibleForTesting LibLevelDB lib]) =>
      _Cache(lib ?? Lib.levelDB, capacity);
}

class _Cache implements Cache {
  final LibLevelDB lib;

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
