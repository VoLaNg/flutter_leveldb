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
  Pointer<IntPtr> vallen,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_get = Pointer<Utf8> Function(
  Pointer<leveldb_t> db,
  Pointer<leveldb_readoptions_t> options,
  Pointer<Uint8> key,
  IntPtr keylen,
  Pointer<Uint8> val,
  Pointer<IntPtr> vallen,
  Pointer<Pointer<Utf8>> errptr,
);

/// Returns Null-terminated string
/// ```c
/// /* Returns NULL if property name is unknown.
///    Else returns a pointer to a malloc()-ed null-terminated value. */
/// LEVELDB_EXPORT char* leveldb_property_value(leveldb_t* db,
///                                             const char* propname);
/// ```
typedef Leveldb_property_value = Pointer<Utf8> Function(
  Pointer<leveldb_t> db,
  Pointer<Utf8> propname,
);
typedef leveldb_property_value = Pointer<Utf8> Function(
  Pointer<leveldb_t> db,
  Pointer<Utf8> propname,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_approximate_sizes(
///     leveldb_t* db, int num_ranges, const char* const* range_start_key,
///     const size_t* range_start_key_len, const char* const* range_limit_key,
///     const size_t* range_limit_key_len, uint64_t* sizes);
/// ```
typedef Leveldb_approximate_sizes = void Function(
  Pointer<leveldb_t> db,
  int num_ranges,
  Pointer<Pointer<Uint8>> range_start_key,
  Pointer<IntPtr> range_start_key_len,
  Pointer<Pointer<Uint8>> range_limit_key,
  Pointer<IntPtr> range_limit_key_len,
  Pointer<Uint64> sizes,
);
typedef leveldb_approximate_sizes = Void Function(
  Pointer<leveldb_t> db,
  IntPtr num_ranges,
  Pointer<Pointer<Uint8>> range_start_key,
  Pointer<IntPtr> range_start_key_len,
  Pointer<Pointer<Uint8>> range_limit_key,
  Pointer<IntPtr> range_limit_key_len,
  Pointer<Uint64> sizes,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_compact_range(leveldb_t* db, const char* start_key,
///                                           size_t start_key_len,
///                                           const char* limit_key,
///                                           size_t limit_key_len);
/// ```
typedef Leveldb_compact_range = void Function(
  Pointer<leveldb_t> db,
  Pointer<Uint8> start_key,
  int start_key_len,
  Pointer<Uint8> limit_key,
  int limit_key_len,
);
typedef leveldb_compact_range = Void Function(
  Pointer<leveldb_t> db,
  Pointer<Uint8> start_key,
  IntPtr start_key_len,
  Pointer<Uint8> limit_key,
  IntPtr limit_key_len,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_destroy_db(const leveldb_options_t* options,
///                                        const char* name, char** errptr);
/// ```
typedef Leveldb_destroy_db = void Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_destroy_db = Void Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_repair_db(const leveldb_options_t* options,
///                                        const char* name, char** errptr);
/// ```
typedef Leveldb_repair_db = void Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);
typedef leveldb_repair_db = Void Function(
  Pointer<leveldb_options_t> options,
  Pointer<Utf8> name,
  Pointer<Pointer<Utf8>> errptr,
);

/// ```c
/// /* Calls free(ptr).
///    REQUIRES: ptr was malloc()-ed and returned by one of the routines
///    in this file.  Note that in certain cases (typically on Windows), you
///    may need to call this routine instead of free(ptr) to dispose of
///    malloc()-ed memory returned by this library. */
/// LEVELDB_EXPORT void leveldb_free(void* ptr);
/// ```
typedef Leveldb_free = void Function(
  Pointer<Void> options,
);
typedef leveldb_free = Void Function(
  Pointer<Void> options,
);

/// ```c
/// /* Return the major version number for this release. */
/// LEVELDB_EXPORT int leveldb_major_version(void);
/// ```
typedef Leveldb_major_version = int Function();
typedef leveldb_major_version = IntPtr Function();

/// ```c
/// /* Return the minor version number for this release. */
/// LEVELDB_EXPORT int leveldb_minor_version(void);
/// ```
typedef Leveldb_minor_version = int Function();
typedef leveldb_minor_version = IntPtr Function();
