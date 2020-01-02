import 'dart:ffi';

class leveldb_cache_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_cache_t* leveldb_cache_create_lru(size_t capacity);
/// ```
typedef Leveldb_cache_create_lru = Pointer<leveldb_cache_t> Function(int);
typedef leveldb_cache_create_lru = Pointer<leveldb_cache_t> Function(IntPtr);

/// ```c
/// LEVELDB_EXPORT void leveldb_cache_destroy(leveldb_cache_t* cache);
/// ```
typedef Leveldb_cache_destroy = void Function(Pointer<leveldb_cache_t>);
typedef leveldb_cache_destroy = Void Function(Pointer<leveldb_cache_t>);
