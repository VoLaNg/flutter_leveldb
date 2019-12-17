import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:leveldb/interop/src/leveldb_writebatch_t.dart';

import 'leveldb_options_t.dart';
import 'leveldb_readoptions_t.dart';
import 'leveldb_writeoptions_t.dart';

/// ```c
/// typedef struct leveldb_t leveldb_t;
/// ```
class leveldb_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_t* leveldb_open(const leveldb_options_t* options,
///                                        const char* name, char** errptr);
/// ```
typedef Leveldb_open = Pointer<leveldb_t> Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_open = Pointer<leveldb_t> Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_close(leveldb_t* db);
/// ```
typedef Leveldb_close = void Function(Pointer<leveldb_t> db);
typedef leveldb_close = Void Function(Pointer<leveldb_t> db);

/// ```c
/// LEVELDB_EXPORT void leveldb_put(leveldb_t* db,
///                                 const leveldb_writeoptions_t* options,
///                                 const char* key, size_t keylen, const char* val,
///                                 size_t vallen, char** errptr);
/// ```
typedef Leveldb_put = void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<Uint8> key,
  int keylen,
  Pointer<Uint8> val,
  int vallen,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_put = Void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<Uint8> key,
  IntPtr keylen,
  Pointer<Uint8> val,
  IntPtr vallen,
  Pointer<Pointer<Utf8>> errptr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_delete(leveldb_t* db,
///                                    const leveldb_writeoptions_t* options,
///                                    const char* key, size_t keylen,
///                                    char** errptr);
/// ```
typedef Leveldb_delete = void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<Uint8> key,
  int keylen,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_delete = Void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<Uint8> key,
  IntPtr keylen,
  Pointer<Pointer<Utf8>> errptr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_write(leveldb_t* db,
///                                   const leveldb_writeoptions_t* options,
///                                   leveldb_writebatch_t* batch, char** errptr);
/// ```
typedef Leveldb_write = void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<leveldb_writebatch_t> batch,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_write = Void Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_writeoptions_t> options,
  Pointer<leveldb_writebatch_t> batch,
  Pointer<Pointer<Utf8>> errptr,
);

/// Returns NULL if not found.  A malloc()ed array otherwise.
/// Stores the length of the array in *vallen.
/// ```c
/// LEVELDB_EXPORT char* leveldb_get(leveldb_t* db,
///                                  const leveldb_readoptions_t* options,
///                                  const char* key, size_t keylen, size_t* vallen,
///                                  char** errptr);
/// ```
typedef Leveldb_get = Pointer<Utf8> Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_readoptions_t> options,
  Pointer<Uint8> key,
  int keylen,
  Pointer<Uint8> val,
  int vallen,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_get = Pointer<Utf8> Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_readoptions_t> options,
  Pointer<Uint8> key,
  IntPtr keylen,
  Pointer<Uint8> val,
  IntPtr vallen,
  Pointer<Pointer<Utf8>> errptr,
);
