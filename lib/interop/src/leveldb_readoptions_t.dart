import 'dart:ffi';
import 'leveldb_snapshot_t.dart';

/// ```c
/// typedef struct leveldb_readoptions_t leveldb_readoptions_t;
/// ```
class leveldb_readoptions_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_readoptions_t* leveldb_readoptions_create(void);
/// ```
typedef Leveldb_readoptions_create = Pointer<leveldb_readoptions_t> Function();
typedef leveldb_readoptions_create = Pointer<leveldb_readoptions_t> Function();

/// ```c
/// LEVELDB_EXPORT void leveldb_readoptions_destroy(leveldb_readoptions_t*);
/// ```
typedef Leveldb_readoptions_destroy = void Function(Pointer<leveldb_readoptions_t>);
typedef leveldb_readoptions_destroy = Void Function(Pointer<leveldb_readoptions_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_readoptions_set_verify_checksums(
///     leveldb_readoptions_t*, uint8_t);
/// ```
typedef Leveldb_readoptions_set_verify_checksums = void Function(Pointer<leveldb_readoptions_t>, int);
typedef leveldb_readoptions_set_verify_checksums = Void Function(Pointer<leveldb_readoptions_t>, Uint8);

/// ```c
/// LEVELDB_EXPORT void leveldb_readoptions_set_fill_cache(leveldb_readoptions_t*,
///                                                        uint8_t);
/// ```
typedef Leveldb_readoptions_set_fill_cache = void Function(Pointer<leveldb_readoptions_t>, int);
typedef leveldb_readoptions_set_fill_cache = Void Function(Pointer<leveldb_readoptions_t>, Uint8);

/// ```c
/// LEVELDB_EXPORT void leveldb_readoptions_set_snapshot(leveldb_readoptions_t*,
///                                                      const leveldb_snapshot_t*);
/// ```
typedef Leveldb_readoptions_set_snapshot = void Function(Pointer<leveldb_readoptions_t>, Pointer<leveldb_snapshot_t>);
typedef leveldb_readoptions_set_snapshot = Void Function(Pointer<leveldb_readoptions_t>, Pointer<leveldb_snapshot_t>);