import 'dart:ffi';

import 'package:ffi/ffi.dart';

class leveldb_filterpolicy_t extends Struct {}

/// ```c
/// void (*destructor)(void*)
/// ```
typedef Filterpolicy_destructor = void Function(Pointer<Void>);
typedef filterpolicy_destructor = Void Function(Pointer<Void>);

/// ```c
/// char* (*create_filter)(void*, const char* const* key_array,
///                        const size_t* key_length_array, int num_keys,
///                        size_t* filter_length)
/// ```
typedef Filterpolicy_create_filter = Pointer<Uint8> Function(
  Pointer<Void>,
  Pointer<Pointer<Uint8>> key_array,
  Pointer<IntPtr> key_length_array,
  int num_keys,
  Pointer<IntPtr> filter_length,
);
typedef filterpolicy_create_filter = Pointer<Uint8> Function(
  Pointer<Void>,
  Pointer<Pointer<Uint8>> key_array,
  Pointer<IntPtr> key_length_array,
  IntPtr num_keys,
  Pointer<IntPtr> filter_length,
);

/// ```c
/// uint8_t (*key_may_match)(void*, const char* key, size_t length,
///                          const char* filter, size_t filter_length)
/// ```
typedef Filterpolicy_key_may_match = int Function(
  Pointer<Void>,
  Pointer<Uint8> key,
  int length,
  Pointer<Uint8> filter,
  int filter_length,
);
typedef filterpolicy_key_may_match = Uint8 Function(
  Pointer<Void>,
  Pointer<Uint8> key,
  IntPtr length,
  Pointer<Uint8> filter,
  IntPtr filter_length,
);

/// ```c
/// const char* (*name)(void*)
/// ```
typedef Filterpolicy_name = Pointer<Utf8> Function(Pointer<Void>);
typedef filterpolicy_name = Pointer<Utf8> Function(Pointer<Void>);

/// ```c
/// LEVELDB_EXPORT leveldb_filterpolicy_t* leveldb_filterpolicy_create(
///     void* state, void (*destructor)(void*),
///     char* (*create_filter)(void*, const char* const* key_array,
///                            const size_t* key_length_array, int num_keys,
///                            size_t* filter_length),
///     uint8_t (*key_may_match)(void*, const char* key, size_t length,
///                              const char* filter, size_t filter_length),
///     const char* (*name)(void*));
/// ```
typedef Leveldb_filterpolicy_create = Pointer<leveldb_filterpolicy_t> Function(
  Pointer<NativeFunction<filterpolicy_destructor>> destructor,
  Pointer<NativeFunction<filterpolicy_create_filter>> create_filter,
  Pointer<NativeFunction<filterpolicy_key_may_match>> key_may_match,
  Pointer<NativeFunction<filterpolicy_name>> name,
);
typedef leveldb_filterpolicy_create = Pointer<leveldb_filterpolicy_t> Function(
  Pointer<NativeFunction<filterpolicy_destructor>> destructor,
  Pointer<NativeFunction<filterpolicy_create_filter>> create_filter,
  Pointer<NativeFunction<filterpolicy_key_may_match>> key_may_match,
  Pointer<NativeFunction<filterpolicy_name>> name,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_filterpolicy_destroy(leveldb_filterpolicy_t*);
/// ```
typedef Leveldb_filterpolicy_destroy = void Function(
  Pointer<leveldb_filterpolicy_t>,
);
typedef leveldb_filterpolicy_destroy = Void Function(
  Pointer<leveldb_filterpolicy_t>,
);

/// ```c
/// LEVELDB_EXPORT leveldb_filterpolicy_t* leveldb_filterpolicy_create_bloom(
///    int bits_per_key);
/// ```
typedef Leveldb_filterpolicy_create_bloom = Pointer<leveldb_filterpolicy_t>
    Function(int bits_per_key);
typedef leveldb_filterpolicy_create_bloom = Pointer<leveldb_filterpolicy_t>
    Function(IntPtr bits_per_key);
