import 'dart:ffi';

import 'leveldb_t.dart';

/// ```c
/// typedef struct leveldb_snapshot_t leveldb_snapshot_t;
/// ```
class leveldb_snapshot_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT const leveldb_snapshot_t* leveldb_create_snapshot(leveldb_t* db);
/// ```
typedef Leveldb_create_snapshot = Pointer<leveldb_snapshot_t> Function(
  Pointer<leveldb_t> db,
);
typedef leveldb_create_snapshot = Pointer<leveldb_snapshot_t> Function(
  Pointer<leveldb_t> db,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_release_snapshot(
///     leveldb_t* db, const leveldb_snapshot_t* snapshot);
/// ```
typedef Leveldb_release_snapshot = void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_snapshot_t> snapshot,
);
typedef leveldb_release_snapshot = Void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_snapshot_t> snapshot,
);
