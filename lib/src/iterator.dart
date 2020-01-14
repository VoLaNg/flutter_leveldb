import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:leveldb/src/kv_entry.dart';
import 'package:leveldb/src/library.dart';
import 'package:leveldb/src/utils.dart';
import 'package:meta/meta.dart';

import 'extensions.dart';
import 'native_wrapper.dart';
import 'raw_data.dart';

/// An iterator yields a sequence of key/value pairs from a source.
/// The following class defines the interface.  Multiple implementations
/// are provided by this library.  In particular, iterators are provided
/// to access the contents of a Table or a DB.
abstract class DBIterator extends AnyStructure
    implements Iterator<KeyValue<RawData, RawData>> {
  factory DBIterator.atPosition({
    Pointer<leveldb_iterator_t> dbptr,
    Position<RawData> initialPosition = const Position(),
    @visibleForTesting LibLevelDB lib,
  }) {
    final itr = _DBIterator.ptr(lib ?? Lib.levelDB, dbptr);
    initialPosition?.setPosition(itr);
    return itr;
  }

  /// An iterator is either positioned at a key/value pair, or
  /// not valid. This method returns true iff the iterator is valid.
  bool get isValid;

  /// Position at the first key in the source. The iterator [DBIterator.isValid]
  /// after this call iff the source is not empty.
  void seekToFirst();

  /// Position at the last key in the source. The iterator [DBIterator.isValid]
  /// after this call iff the source is not empty.
  void seekToLast();

  /// Position at the first key in the source that is at or past target.
  /// The iterator [DBIterator.isValid] after this call iff the source contains
  /// an entry that comes at or past target.
  void seek(RawData targetKey);

  /// Moves to the next entry in the source.  After this call, [DBIterator.isValid]
  /// is true iff the iterator was not positioned at the last entry in the source.
  /// REQUIRES: [DBIteratorisValid]
  void next();

  /// Moves to the previous entry in the source.  After this call, [DBIterator.isValid]
  /// is true iff the iterator was not positioned at the first entry in source.
  /// REQUIRES: [DBIterator.isValid]
  void prev();

  /// Return the key for the current entry.  The underlying storage for
  /// the returned slice is valid only until the next modification of
  /// the iterator.
  /// REQUIRES: [DBIterator.isValid]
  RawData key();

  /// Return the value for the current entry.  The underlying storage for
  /// the returned slice is valid only until the next modification of
  /// the iterator.
  /// REQUIRES: [DBIterator.isValid]
  RawData value();

  /// If an error has occurred, return it.  Else return null
  Exception getError();
}

class Position<V> {
  final bool isFirst;
  final bool isLast;
  final V target;

  const Position()
      : isFirst = true,
        isLast = false,
        target = null;
  const Position.first() : this();
  const Position.last()
      : isFirst = false,
        isLast = true,
        target = null;
  const Position.target(V target)
      : isFirst = false,
        isLast = false,
        target = target;
}

extension on Position<RawData> {
  void setPosition(DBIterator itr) {
    if (isFirst) {
      itr.seekToFirst();
      return;
    }
    if (isLast) {
      itr.seekToLast();
      return;
    }
    if (target != null) {
      itr.seek(target);
      return;
    }
  }
}

class _DBIterator implements DBIterator {
  final LibLevelDB lib;
  @override
  Pointer<leveldb_iterator_t> ptr;

  _DBIterator.ptr(this.lib, this.ptr);

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbIterDestroy(ptr);
    ptr = nullptr;
  }

  @override
  Exception getError() {
    try {
      errorHandler((errPtr) => lib.leveldbIterGetError(ptr, errPtr));
      return null;
    } catch (e) {
      return e;
    }
  }

  @override
  bool get isValid {
    if (isDisposed) return false;
    return lib.leveldbIterValid(ptr) == 1;
  }

  @override
  RawData key() {
    attemptTo('key');
    return allocctx((Pointer<IntPtr> keySize) {
      final key = lib.leveldbIterKey(ptr, keySize);
      return RawData.native(key, keySize.value);
    });
  }

  @override
  void next() {
    attemptTo('next');
    lib.leveldbIterNext(ptr);
  }

  @override
  void prev() {
    attemptTo('prev');
    lib.leveldbIterPrev(ptr);
  }

  @override
  void seek(RawData targetKey) {
    attemptTo('seek');
    lib.leveldbIterSeek(ptr, targetKey.ptr, targetKey.length);
  }

  @override
  void seekToFirst() {
    attemptTo('seekToFirst');
    lib.leveldbIterSeekToFirst(ptr);
  }

  @override
  void seekToLast() {
    attemptTo('seekToLast');
    lib.leveldbIterSeekToLast(ptr);
  }

  @override
  RawData value() {
    attemptTo('value');
    return allocctx((Pointer<IntPtr> valueSize) {
      final value = lib.leveldbIterValue(ptr, valueSize);
      return RawData.native(value, valueSize.value);
    });
  }

  // --- Iterator overrides ---
  KeyValue<RawData, RawData> _current;

  @override
  KeyValue<RawData, RawData> get current {
    if (!isValid) return null;
    _current ??= KeyValue(key(), value());
    return _current;
  }

  @override
  bool moveNext() {
    _current = null;
    next();
    return isValid;
  }
}
