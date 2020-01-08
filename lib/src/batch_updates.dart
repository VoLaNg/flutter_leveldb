import 'dart:ffi';
import 'package:leveldb/interop/interop.dart';

import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';
import 'raw_data.dart';

/// [BatchUpdates] holds a collection of updates to apply atomically to a DB.
///
/// The updates are applied in the order in which they are added
/// to the [BatchUpdates].  For example, the value of [key] will be "v3"
/// after the following batch is written:
///
///    batch.Put("key", "v1");
///    batch.Delete("key");
///    batch.Put("key", "v2");
///    batch.Put("key", "v3");
///
/// Multiple threads can invoke const methods on a [BatchUpdates] without
/// external synchronization, but if any of the threads may call a
/// non-const method, all threads accessing the same [BatchUpdates] must use
/// external synchronization.
abstract class BatchUpdates extends NativeWrapper {
  /// Store the mapping "key->value" in the database.
  /// throws [StateError] if method was called after [BatchUpdates.dispose]
  void put(RawData key, RawData value);

  /// Copies the operations in "source" to this batch.
  /// throws [StateError] if method was called after [BatchUpdates.dispose]
  void append(BatchUpdates updates);

  /// If the database contains a mapping for [key], erase it.  Else do nothing.
  /// throws [StateError] if method was called after [BatchUpdates.dispose]
  void delete(RawData key);

  /// Clear all updates buffered in this batch.
  void clear();

  void operator +(BatchUpdates obj);

  factory BatchUpdates() => _BatchUpdates(Lib.levelDB);
}

class _BatchUpdates implements BatchUpdates {
  final LibLevelDB lib;

  @override
  Pointer<leveldb_writebatch_t> ptr;

  _BatchUpdates(this.lib) : ptr = lib.leveldbWritebatchCreate();

  @override
  void operator +(BatchUpdates obj) {
    return append(obj);
  }

  @override
  void append(BatchUpdates updates) {
    attemptTo('append');
    updates.attemptTo('append');

    lib.leveldbWritebatchAppend(ptr, updates.ptr);
  }

  @override
  void put(RawData key, RawData value) {
    attemptTo('put');

    return lib.leveldbWritebatchPut(
      ptr,
      key.ptr,
      key.length,
      value.ptr,
      value.length,
    );
  }

  @override
  void delete(RawData key) {
    attemptTo('delete');

    return lib.leveldbWritebatchDelete(ptr, key.ptr, key.length);
  }

  @override
  void clear() {
    if (isDisposed) return;

    lib.leveldbWritebatchClear(ptr);
  }

  @override
  void dispose() {
    if (isDisposed) return;

    lib.leveldbWritebatchDestroy(ptr);
  }
}
