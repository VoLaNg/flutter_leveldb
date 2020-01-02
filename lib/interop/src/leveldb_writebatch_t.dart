import 'dart:ffi';

class leveldb_writebatch_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_writebatch_t* leveldb_writebatch_create(void);
/// ```
typedef Leveldb_writebatch_create = Pointer<leveldb_writebatch_t> Function();
typedef leveldb_writebatch_create = Pointer<leveldb_writebatch_t> Function();

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_destroy(leveldb_writebatch_t*);
/// ```
typedef Leveldb_writebatch_destroy = void Function(
    Pointer<leveldb_writebatch_t>);
typedef leveldb_writebatch_destroy = Void Function(
    Pointer<leveldb_writebatch_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_clear(leveldb_writebatch_t*);
/// ```
typedef Leveldb_writebatch_clear = void Function(Pointer<leveldb_writebatch_t>);
typedef leveldb_writebatch_clear = Void Function(Pointer<leveldb_writebatch_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_put(leveldb_writebatch_t*,
///                                           const char* key, size_t klen,
///                                           const char* val, size_t vlen);
/// ```
typedef Leveldb_writebatch_put = void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Uint8> key,
  int klen,
  Pointer<Uint8> val,
  int vlen,
);
typedef leveldb_writebatch_put = Void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Uint8> key,
  IntPtr klen,
  Pointer<Uint8> val,
  IntPtr vlen,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_delete(leveldb_writebatch_t*,
///                                              const char* key, size_t klen);
/// ```
typedef Leveldb_writebatch_delete = void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Uint8> key,
  int klen,
);
typedef leveldb_writebatch_delete = Void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Uint8> key,
  IntPtr klen,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_iterate(
///    const leveldb_writebatch_t*, void* state,
///    void (*put)(void*, const char* k, size_t klen, const char* v, size_t vlen),
///    void (*deleted)(void*, const char* k, size_t klen));
/// ```
typedef writebatch_iterate_put = Void Function(
  Pointer<Void>,
  Pointer<Uint8> k,
  IntPtr klen,
  Pointer<Uint8> v,
  IntPtr vlen,
);
typedef writebatch_iterate_deleted = Void Function(
  Pointer<Void>,
  Pointer<Uint8> k,
  IntPtr klen,
);
typedef Leveldb_writebatch_iterate = void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Void> state,
  Pointer<NativeFunction<writebatch_iterate_put>> put,
  Pointer<NativeFunction<writebatch_iterate_deleted>> deleted,
);
typedef leveldb_writebatch_iterate = Void Function(
  Pointer<leveldb_writebatch_t>,
  Pointer<Void> state,
  Pointer<NativeFunction<writebatch_iterate_put>> put,
  Pointer<NativeFunction<writebatch_iterate_deleted>> deleted,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_writebatch_append(
///    leveldb_writebatch_t* destination, const leveldb_writebatch_t* source);
/// ```
typedef Leveldb_writebatch_append = void Function(
  Pointer<leveldb_writebatch_t> destination,
  Pointer<leveldb_writebatch_t> source,
);
typedef leveldb_writebatch_append = Void Function(
  Pointer<leveldb_writebatch_t> destination,
  Pointer<leveldb_writebatch_t> source,
);
