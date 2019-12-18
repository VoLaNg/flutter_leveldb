import 'dart:ffi';

/// ```c
/// typedef struct leveldb_writeoptions_t leveldb_writeoptions_t;
/// ```
class leveldb_writeoptions_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_writeoptions_t* leveldb_writeoptions_create(void);
/// ```
typedef Leveldb_writeoptions_create = Pointer<leveldb_writeoptions_t> Function();
typedef leveldb_writeoptions_create = Pointer<leveldb_writeoptions_t> Function();

/// ```c
/// LEVELDB_EXPORT void leveldb_writeoptions_destroy(leveldb_writeoptions_t*);
/// ```
typedef Leveldb_writeoptions_destroy = void Function(Pointer<leveldb_writeoptions_t>);
typedef leveldb_writeoptions_destroy = Void Function(Pointer<leveldb_writeoptions_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_writeoptions_set_sync(leveldb_writeoptions_t*,
///                                                   uint8_t);
/// ```
typedef Leveldb_writeoptions_set_sync = void Function(Pointer<leveldb_writeoptions_t>, int,);
typedef leveldb_writeoptions_set_sync = Void Function(Pointer<leveldb_writeoptions_t>, Uint8,);