import 'dart:ffi';

import 'package:ffi/ffi.dart';

class leveldb_comparator_t extends Struct {}

/// ```c
/// void (*destructor)(void*)
/// ```
typedef Comparator_destructor = void Function(Pointer<Void>);
typedef comparator_destructor = Void Function(Pointer<Void>);

/// ```c
/// int (*compare)(void*, const char* a, size_t alen, const char* b,
///                size_t blen)
/// ```
typedef Comparator_compare = int Function(
  Pointer<Void>,
  Pointer<Utf8> a,
  int alen,
  Pointer<Utf8> b,
  int blen,
);
typedef comparator_compare = IntPtr Function(
  Pointer<Void>,
  Pointer<Utf8> a,
  IntPtr alen,
  Pointer<Utf8> b,
  IntPtr blen,
);

/// ```c
/// const char* (*name)(void*)
/// ```
typedef Comparator_name = Pointer<Utf8> Function(Pointer<Void>);
typedef comparator_name = Pointer<Utf8> Function(Pointer<Void>);

/// ```c
/// LEVELDB_EXPORT leveldb_comparator_t* leveldb_comparator_create(
///     void* state, void (*destructor)(void*),
///     int (*compare)(void*, const char* a, size_t alen, const char* b,
///                    size_t blen),
///     const char* (*name)(void*));
/// ```
typedef Leveldb_comparator_create = Pointer<leveldb_comparator_t> Function(
  Pointer<NativeFunction<comparator_destructor>> destructor,
  Pointer<NativeFunction<comparator_compare>> compare,
  Pointer<NativeFunction<comparator_name>> name,
);
typedef leveldb_comparator_create = Pointer<leveldb_comparator_t> Function(
  Pointer<NativeFunction<comparator_destructor>> destructor,
  Pointer<NativeFunction<comparator_compare>> compare,
  Pointer<NativeFunction<comparator_name>> name,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_comparator_destroy(leveldb_comparator_t*);
/// ```
typedef Leveldb_comparator_destroy = void Function(
  Pointer<leveldb_comparator_t>,
);
typedef leveldb_comparator_destroy = Void Function(
  Pointer<leveldb_comparator_t>,
);
