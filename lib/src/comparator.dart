import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart';

import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';

// !: [Pointer.fromFunction] returned function address can only be invoked on the mutator (main)
// !: thread of the current isolate. It will abort the process if invoked on any
// !: other thread.
// TODO: testing is required
/// A Comparator object provides a total order across slices that are
/// used as keys in an sstable or a database.  A Comparator implementation
/// must be thread-safe since leveldb may invoke its methods concurrently
/// from multiple threads.
@experimental
abstract class Comparator extends NativeWrapper {
  factory Comparator({
    @required Pointer<NativeFunction<comparator_destructor>> destructor,
    @required Pointer<NativeFunction<comparator_compare>> compare,
    @required Pointer<NativeFunction<comparator_name>> name,
  }) {
    assert(destructor != null);
    assert(compare != null);
    assert(name != null);
    return _Comparator(
      Lib.levelDB,
      destructor: destructor,
      compare: compare,
      name: name,
    );
  }
}

class _Comparator implements Comparator {
  final LibLevelDB _lib;

  _Comparator(
    this._lib, {
    @required Pointer<NativeFunction<comparator_destructor>> destructor,
    @required Pointer<NativeFunction<comparator_compare>> compare,
    @required Pointer<NativeFunction<comparator_name>> name,
  }) : ptr = _lib.leveldbComparatorCreate(
          destructor,
          compare,
          name,
        );

  @override
  Pointer<leveldb_comparator_t> ptr;

  @override
  void dispose() {
    if (isDisposed) return;
    _lib.leveldbComparatorDestroy(ptr);
    ptr = nullptr;
  }
}
