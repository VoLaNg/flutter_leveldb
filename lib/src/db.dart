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
  /// Open the database with the specified [filePath].
  factory LevelDB.open({
    @required Options options,
    @required String filePath,
  }) {
    assert(
      options != null,
      'LevelDB.open: "options" parameter is required',
    );
    assert(
      !options.isDisposed,
      'LevelDB.open: "options" parameter is disposed',
    );
    assert(
      filePath?.isNotEmpty ?? false,
      'LevelDB.open: "filePath" parameter is required',
    );
    return _LevelDB.open(
      Lib.levelDB,
      options: options,
      name: filePath,
    );
  }

  factory LevelDB.pointer({
    @required Pointer<leveldb_t> pointer,
    @required Options options,
  }) {
    assert(
      options != null,
      'LevelDB.open: "options" parameter is required',
    );
    assert(
      !options.isDisposed,
      'LevelDB.open: "options" parameter is disposed',
    );
    assert(
      pointer != null && pointer != nullptr,
      'LevelDB.open: "pointer" parameter is required',
    );
    return _LevelDB.ptr(
      Lib.levelDB,
      options: options,
      ptr: pointer,
    );
  }

  /// If a DB cannot be opened, you may attempt to call this method to
  /// resurrect as much of the contents of the database as possible.
  /// Some data may be lost, so be careful when calling this function
  /// on a database that contains important information.
  ///
  /// throws [LevelDBException]
  static void repair(String filePath, Options options) {
    return _SLevelDB.repair(filePath, options);
  }

  /// Destroy the contents of the specified database.
  /// Be very careful using this method.
  ///
  /// Note: For backwards compatibility, if DestroyDB is unable to list the
  /// database files, Status::OK() will still be returned masking this failure.
  ///
  /// throws [LevelDBException]
  static void destroy(String filePath, Options options) {
    return _SLevelDB.destroy(filePath, options);
  }

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
    RawData key, {
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  });

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
  Iterator<KeyValue<RawData, RawData>> iterator({
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  });

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
  void put(RawData key, RawData value, {bool ensured = false});

  /// Set the database entry for [key] to [value].
  ///
  /// If [ensured] == true, the write will be flushed from the operating system
  /// buffer cache before the write is considered complete.
  /// If this flag is true, writes will be slower.
  /// If this flag is false, and the machine crashes, some recent
  /// writes may be lost.
  void delete(RawData key, {bool ensured = false});

  /// Apply the specified updates to the database.
  ///
  /// If [ensured] == true, the write will be flushed from the operating system
  /// buffer cache before the write is considered complete.
  /// If this flag is true, writes will be slower.
  /// If this flag is false, and the machine crashes, some recent
  /// writes may be lost.
  void write(BatchUpdates updates, {bool ensured = false});

  /// Return a handle to the current DB state.  Iterators created with
  /// this handle will all observe a stable snapshot of the current DB
  /// state.  The caller must call [Snapshot.dispose] when the
  /// snapshot is no longer needed.
  Snapshot getSnapshot();

  /// Closes the database.
  /// After closing any database invocations or using [LevelDB.options] are prohibited.
  /// Make sure you [dispose] all created snapshots before this call.
  void close();

  /// Compact the underlying storage for the key range [*begin,*end].
  /// In particular, deleted and overwritten versions are discarded,
  /// and the data is rearranged to reduce the cost of operations
  /// needed to access the data.  This operation should typically only
  /// be invoked by users who understand the underlying implementation.
  ///
  /// [beginKey] == null is treated as a key before all keys in the database.
  /// [endKey] == null is treated as a key after all keys in the database.
  /// Therefore the following call will compact the entire database:
  /// [LevelDB.compact(null, null)]
  void compact(RawData beginKey, RawData endKey);

  // --- Statistics ---

  /// Number of files at level
  int numFilesAtLevel(int level);

  /// returns a multi-line string that describes statistics
  /// about the internal operation of the DB
  String stats();

  /// returns a multi-line string that describes all
  /// of the sstables that make up the db contents.
  String sstables();

  /// returns the approximate number of
  /// bytes of memory in use by the DB.
  int approximateMemoryUsage();
}

abstract class _Properties {
  static const num_files_at_level = 'leveldb.num-files-at-level<N>';
  static const stats = 'leveldb.stats';
  static const sstables = 'leveldb.sstables';
  static const approximate_memory_usage = 'leveldb.approximate-memory-usage';
}

extension _SLevelDB on _LevelDB {
  static void repair(String filePath, Options options) {
    return errorHandler((errPtr) {
      return allocctx((strPtr) {
        // ignore: invalid_use_of_protected_member
        return Lib.levelDB.leveldbRepairDb(options.ptr, strPtr, errPtr);
      }, () => Utf8.toUtf8(filePath));
    });
  }

  static void destroy(String filePath, Options options) {
    return errorHandler((errPtr) {
      return allocctx((strPtr) {
        // ignore: invalid_use_of_protected_member
        return Lib.levelDB.leveldbDestroyDb(options.ptr, strPtr, errPtr);
      }, () => Utf8.toUtf8(filePath));
    });
  }
}

class _LevelDB extends DisposablePointer<leveldb_t> implements LevelDB {
  final LibLevelDB lib;
  final Options options;

  @override
  Pointer<leveldb_t> ptr;

  _LevelDB.open(
    this.lib, {
    @required this.options,
    @required String name,
  }) : ptr = _open(options, name, lib);

  _LevelDB.ptr(
    this.lib, {
    @required this.ptr,
    @required this.options,
  });

  static Pointer<leveldb_t> _open(
    Options options,
    String name,
    LibLevelDB lib,
  ) {
    return allocctx((Pointer<Utf8> strptr) {
      return errorHandler(
        // ignore: invalid_use_of_protected_member
        (errptr) => lib.leveldbOpen(options.ptr, strptr, errptr),
      );
    }, () => Utf8.toUtf8(name));
  }

  @override
  void close() => dispose();

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbClose(ptr);
    ptr = nullptr;
    options?.dispose();
  }

  @override
  void delete(RawData key, {bool ensured = false}) {
    assert(key != null && !key.isDisposed, 'Key is empty');
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
    RawData key, {
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
  }) {
    assert(key != null && !key.isDisposed, 'Key is empty');
    attemptTo('get');
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
  Iterator<KeyValue<RawData, RawData>> iterator({
    bool verifyChecksums = false,
    bool fillCache = true,
    Snapshot snapshot,
    Position<RawData> initialPosition = const Position.first(),
  }) {
    attemptTo('iterator');
    // ignore: invalid_use_of_protected_member
    final readOptionsAreDefault = ReadOptions.isEqualToDefault(
      verifyChecksums: verifyChecksums,
      fillCache: fillCache,
      snapshot: snapshot,
    );

    DBIterator exec(ReadOptions readOptions) {
      return DBIterator.atPosition(
        dbptr: lib.leveldbCreateIterator(ptr, readOptions.ptr),
        initialPosition: initialPosition,
      );
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
  void put(RawData key, RawData value, {bool ensured = false}) {
    assert(key != null && !key.isDisposed, 'Key is empty');
    assert(value != null && !value.isDisposed, 'Value is empty');
    return errorHandler((errPtr) {
      return lib.leveldbPut(
        ptr,
        ensured ? WriteOptions.sync.ptr : WriteOptions.noSync.ptr,
        key.ptr,
        key.length,
        value.ptr,
        value.length,
        errPtr,
      );
    });
  }

  @override
  void write(BatchUpdates updates, {bool ensured = false}) {
    final _updatesAreValid = !(updates?.isDisposed ?? true);
    assert(_updatesAreValid, 'updates is null or disposed');
    if (!_updatesAreValid) return;

    return errorHandler((errPtr) {
      return lib.leveldbWrite(
        ptr,
        ensured ? WriteOptions.sync.ptr : WriteOptions.noSync.ptr,
        updates.ptr,
        errPtr,
      );
    });
  }

  @override
  Snapshot getSnapshot() {
    attemptTo('getSnapshot');
    return _Snapshot(lib, ptr);
  }

  @override
  void compact(RawData beginKey, RawData endKey) {
    attemptTo('compact');
    return lib.leveldbCompactRange(
      ptr,
      beginKey.ptr,
      beginKey.length,
      endKey.ptr,
      endKey.length,
    );
  }

  String _getProperty(String prop) {
    final str = allocctx((strPtr) {
      return lib.leveldbPropertyValue(ptr, strPtr);
    }, () => Utf8.toUtf8(prop));
    final result = Utf8.fromUtf8(str);
    free(str);
    return result;
  }

  @override
  int approximateMemoryUsage() {
    attemptTo('approximateMemoryUsage');
    return int.tryParse(
      _getProperty(_Properties.approximate_memory_usage),
    );
  }

  @override
  int numFilesAtLevel(int level) {
    attemptTo('numFilesAtLevel');
    return int.tryParse(
      _getProperty(_Properties.num_files_at_level),
    );
  }

  @override
  String sstables() {
    attemptTo('sstables');
    return _getProperty(_Properties.sstables);
  }

  @override
  String stats() {
    attemptTo('stats');
    return _getProperty(_Properties.stats);
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
