import 'dart:ffi';
import 'package:ffi/ffi.dart' hide allocate;
import 'package:leveldb/interop/interop.dart';
import 'package:leveldb/src/write_options.dart';
import 'package:meta/meta.dart';

import 'batch_updates.dart';
import 'extensions.dart';
import 'iterator.dart';
import 'kv_entry.dart';
import 'library.dart';
import 'native_wrapper.dart';
import 'options.dart';
import 'raw_data.dart';
import 'read_options.dart';
import 'snapshot.dart';
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

  /// Returns the corresponding value for [key]
  ///
  /// **[verifyChecksums]**: If true, all data read from underlying
  /// storage will be verified against corresponding checksums.
  ///
  /// **[fillCache]**: Should the data read for this iteration be cached in memory?
  /// Callers may wish to set this field to false for bulk scans.
  ///
  /// **[snapshot]**: If is non-null, read as of the supplied snapshot
  /// (which must belong to the DB that is being read and which must
  /// not have been released).  If [snapshot] is null, use an implicit
  /// snapshot of the state at the beginning of this read operation.
  RawData get(
    RawData key, [
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  ]);

  /// Return an iterator over the contents of the database.
  /// Caller should [dispose] the iterator when it is no longer needed.
  /// The returned iterator should be disposed before this db is disposed.
  ///
  /// **[verifyChecksums]**: If true, all data read from underlying
  /// storage will be verified against corresponding checksums.
  ///
  /// **[fillCache]**: Should the data read for this iteration be cached in memory?
  /// Callers may wish to set this field to false for bulk scans.
  ///
  /// **[snapshot]**: If is non-null, read as of the supplied snapshot
  /// (which must belong to the DB that is being read and which must
  /// not have been released).  If [snapshot] is null, use an implicit
  /// snapshot of the state at the beginning of this read operation.
  Iterator<KeyValue<RawData, RawData>> iterator([
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  ]);

  /// Set the database entry for [key] to [value].
  ///
  /// If [ensured] == true, the write will be flushed from the operating system
  /// buffer cache before the write is considered complete.
  /// If this flag is true, writes will be slower.
  ///
  /// If this flag is false, and the machine crashes, some recent
  /// writes may be lost.  Note that if it is just the process that
  /// crashes (i.e., the machine does not reboot), no writes will be
  /// lost even if [ensured] == false.
  ///
  /// In other words, a DB write with [ensured] == false has similar
  /// crash semantics as the "write()" system call.  A DB write
  /// with [ensured] == true has similar crash semantics to a "write()"
  /// system call followed by "fsync()".
  void put(RawData key, RawData value, [bool ensured = false]);

  /// Set the database entry for [key] to [value].
  ///
  /// If [ensured] == true, the write will be flushed from the operating system
  /// buffer cache before the write is considered complete.
  /// If this flag is true, writes will be slower.
  /// If this flag is false, and the machine crashes, some recent
  /// writes may be lost.
  void delete(RawData key, [bool ensured = false]);

  /// Apply the specified updates to the database.
  ///
  /// If [ensured] == true, the write will be flushed from the operating system
  /// buffer cache before the write is considered complete.
  /// If this flag is true, writes will be slower.
  /// If this flag is false, and the machine crashes, some recent
  /// writes may be lost.
  void write(BatchUpdates updates, [bool ensured = false]);
}

class _LevelDB extends DisposablePointer<leveldb_t> implements LevelDB {
  final LibLevelDB lib;
  final Options options;

  // TODO: async open
  _LevelDB({
    @required this.options,
    @required String name,
    @required this.lib,
  }) : ptr = open(options, name, lib);

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

  @override
  void dispose() {
    if (isDisposed) return;
    free(ptr);
    ptr = nullptr;
    options?.dispose();
  }

  @override
  Pointer<leveldb_t> ptr;

  @override
  void delete(RawData key, [bool ensured = false]) {
    attemptTo('delete');

    return errorHandler((errPtr) => lib.leveldbDelete(
          ptr,
          ensured ? WriteOptions.sync.ptr : WriteOptions.noSync.ptr,
          key.ptr,
          key.length,
          errPtr,
        ));
  }

  @override
  RawData get(
    RawData key, [
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  ]) {
    // ignore: invalid_use_of_protected_member
    final readOptionsAreDefault = ReadOptions.isEqualToDefault(
      verifyChecksums: verifyChecksums,
      fillCache: fillCache,
      snapshot: snapshot,
    );

    RawData exec(ReadOptions readOptions) {
      int valLength;
      final rawDataPtr = allocctx((Pointer<IntPtr> vallen) {
        final result = errorHandler((errptr) {
          return lib.leveldbGet(
            ptr,
            ReadOptions.defaultOptions.ptr,
            key.ptr,
            key.length,
            vallen,
            errptr,
          );
        });
        if (vallen != nullptr) {
          valLength = vallen.value;
        }

        return result;
      });

      return RawData.native(rawDataPtr, valLength);
    }

    if (readOptionsAreDefault) {
      return exec(ReadOptions.defaultOptions);
    } else {
      final options = ReadOptions(
        fillCache: fillCache,
        verifyChecksums: verifyChecksums,
        snapshot: snapshot,
      );
      final result = exec(options);
      options.dispose();
      return result;
    }
  }

  @override
  Iterator<KeyValue<RawData, RawData>> iterator(
      [bool verifyChecksums = false,
      bool fillCache = true,
      Snapshot snapshot]) {
    // TODO: implement iterator
    return null;
  }

  @override
  void put(RawData key, RawData value, [bool ensured = false]) {
    // TODO: implement put
  }

  @override
  void write(BatchUpdates updates, [bool ensured = false]) {
    // TODO: implement write
  }
}

class _Snapshot implements Snapshot {
  final LibLevelDB lib;

  Pointer<leveldb_t> dbptr;

  @override
  Pointer<leveldb_snapshot_t> ptr;

  _Snapshot(this.lib, this.dbptr) : ptr = lib.leveldbCreateSnapshot(dbptr);

  @override
  void dispose() {
    if (this.isDisposed) return;
    if (dbptr == null || dbptr == nullptr) {
      throw StateError('Attempt to [Snapshot.dispose] after [LevelDB.dispose]');
    }
    lib.leveldbReleaseSnapshot(dbptr, ptr);
    ptr = nullptr;
    dbptr = nullptr;
  }
}
