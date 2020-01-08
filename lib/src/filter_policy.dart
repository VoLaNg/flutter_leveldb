import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart';

import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';

/// A database can be configured with a custom FilterPolicy object.
/// This object is responsible for creating a small filter from a set
/// of keys.  These filters are stored in leveldb and are consulted
/// automatically by leveldb to decide whether or not to read some
/// information from disk. In many cases, a filter can cut down the
/// number of disk seeks form a handful to a single disk seek per
/// DB::Get() call.
///
/// Most people will want to use the builtin bloom filter support (see
/// NewBloomFilterPolicy() below).
abstract class FilterPolicy extends NativeWrapper {
  factory FilterPolicy({
    @required Pointer<NativeFunction<filterpolicy_destructor>> destructor,
    @required Pointer<NativeFunction<filterpolicy_create_filter>> createFilter,
    @required Pointer<NativeFunction<filterpolicy_key_may_match>> keyMayMatch,
    @required Pointer<NativeFunction<filterpolicy_name>> name,
  }) {
    assert(destructor != null);
    assert(createFilter != null);
    assert(keyMayMatch != null);
    assert(name != null);
    return _FilterPolicy(
      Lib.levelDB,
      destructor: destructor,
      createFilter: createFilter,
      keyMayMatch: keyMayMatch,
      name: name,
    );
  }

  /// Return a new filter policy that uses a bloom filter with approximately
  /// the specified number of bits per key.  A good value for bits_per_key
  /// is 10, which yields a filter with ~ 1% false positive rate.
  ///
  /// Callers must delete the result after any database that is using the
  /// result has been closed.
  ///
  /// Note: if you are using a custom comparator that ignores some parts
  /// of the keys being compared, you must not use NewBloomFilterPolicy()
  /// and must provide your own FilterPolicy that also ignores the
  /// corresponding parts of the keys.  For example, if the comparator
  /// ignores trailing spaces, it would be incorrect to use a
  /// FilterPolicy (like NewBloomFilterPolicy) that does not ignore
  /// trailing spaces in keys.
  factory FilterPolicy.bloom(int bitsPerKey) =>
      _FilterPolicy.bloom(Lib.levelDB, bitsPerKey);
}

class _FilterPolicy implements FilterPolicy {
  final LibLevelDB _lib;

  _FilterPolicy(
    this._lib, {
    @required Pointer<NativeFunction<filterpolicy_destructor>> destructor,
    @required Pointer<NativeFunction<filterpolicy_create_filter>> createFilter,
    @required Pointer<NativeFunction<filterpolicy_key_may_match>> keyMayMatch,
    @required Pointer<NativeFunction<filterpolicy_name>> name,
  }) : ptr = _lib.leveldbFilterpolicyCreate(
          destructor,
          createFilter,
          keyMayMatch,
          name,
        );

  _FilterPolicy.bloom(
    this._lib,
    int bitsPerKey,
  ) : ptr = _lib.leveldbFilterpolicyCreateBloom(bitsPerKey);

  @override
  Pointer<leveldb_filterpolicy_t> ptr;

  @override
  void dispose() {
    if (isDisposed) return;
    _lib.leveldbFilterpolicyDestroy(ptr);
    ptr = nullptr;
  }
}
