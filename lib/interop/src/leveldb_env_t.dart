import 'dart:ffi';

class leveldb_env_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_env_t* leveldb_create_default_env(void);
/// ```
typedef Leveldb_create_default_env = Pointer<leveldb_env_t> Function();
typedef leveldb_create_default_env = Pointer<leveldb_env_t> Function();

/// ```c
/// LEVELDB_EXPORT void leveldb_env_destroy(leveldb_env_t*);
/// ```
typedef Leveldb_env_destroy = void Function(Pointer<leveldb_env_t>);
typedef leveldb_env_destroy = Void Function(Pointer<leveldb_env_t>);
