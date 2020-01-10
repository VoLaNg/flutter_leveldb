import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:leveldb/interop/src/leveldb_t.dart';

import 'leveldb_readoptions_t.dart';

class leveldb_iterator_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_iterator_t* leveldb_create_iterator(
///     leveldb_t* db, const leveldb_readoptions_t* options);
/// ```
typedef Leveldb_create_iterator = Pointer<leveldb_iterator_t> Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_readoptions_t> options,
);
typedef leveldb_create_iterator = Pointer<leveldb_iterator_t> Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_readoptions_t> options,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_destroy(leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_destroy = void Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_destroy = Void Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT uint8_t leveldb_iter_valid(const leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_valid = int Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_valid = Uint8 Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_seek_to_first(leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_seek_to_first = void Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_seek_to_first = Void Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_seek_to_last(leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_seek_to_last = void Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_seek_to_last = Void Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT Pointer<Utf8> leveldb_iter_seek(leveldb_iterator_t*, const char* k,
///                                       size_t klen);
/// ```
typedef Leveldb_iter_seek = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<Uint8> k,
  int klen,
);
typedef leveldb_iter_seek = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<Uint8> k,
  IntPtr klen,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_next(leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_next = void Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_next = Void Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_prev(leveldb_iterator_t*);
/// ```
typedef Leveldb_iter_prev = void Function(Pointer<leveldb_iterator_t>);
typedef leveldb_iter_prev = Void Function(Pointer<leveldb_iterator_t>);

/// ```c
/// LEVELDB_EXPORT const char* leveldb_iter_key(const leveldb_iterator_t*,
///                                             size_t* klen);
/// ```
typedef Leveldb_iter_key = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<IntPtr> klen,
);
typedef leveldb_iter_key = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<IntPtr> klen,
);

/// ```c
/// LEVELDB_EXPORT const char* leveldb_iter_value(const leveldb_iterator_t*,
///                                             size_t* vlen);
/// ```
typedef Leveldb_iter_value = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<IntPtr> vlen,
);
typedef leveldb_iter_value = Pointer<Uint8> Function(
  Pointer<leveldb_iterator_t>,
  Pointer<IntPtr> vlen,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_iter_get_error(const leveldb_iterator_t*,
///                                            char** errptr);
/// ```
typedef Leveldb_iter_get_error = void Function(
  Pointer<leveldb_iterator_t>,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_iter_get_error = Void Function(
  Pointer<leveldb_iterator_t>,
  Pointer<Pointer<Utf8>> errptr,
);
