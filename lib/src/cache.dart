import 'dart:ffi';

import 'package:ffi/ffi.dart';
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
  bool isDestroyed;

  @override
  Pointer<leveldb_cache_t> get ptr => isDestroyed ? null : _ptr;
  final Pointer<leveldb_cache_t> _ptr;

  _Cache(
    this.lib,
    int capacity,
  ) : _ptr = lib.leveldbCacheCreateLru(capacity);

  @override
  void destroy() {
    if (isDestroyed) return;
    isDestroyed = true;
    lib.leveldbCacheDestroy(_ptr);
    free(_ptr);
  }
}
