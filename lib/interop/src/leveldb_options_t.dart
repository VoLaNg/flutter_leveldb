import 'dart:ffi';

import 'package:leveldb/interop/src/leveldb_comparator_t.dart';
import 'package:leveldb/interop/src/leveldb_filterpolicy_t.dart';

import 'leveldb_cache_t.dart';
import 'leveldb_env_t.dart';
import 'leveldb_logger_t.dart';

/// ```c
/// typedef struct leveldb_options_t leveldb_options_t;
/// ```
class leveldb_options_t extends Struct {}

/// ```c
/// LEVELDB_EXPORT leveldb_options_t* leveldb_options_create(void);
/// ```
typedef Leveldb_options_create = Pointer<leveldb_options_t> Function();
typedef leveldb_options_create = Pointer<leveldb_options_t> Function();

/// ```c
/// LEVELDB_EXPORT void leveldb_options_destroy(leveldb_options_t*);
/// ```
typedef Leveldb_options_destroy = void Function(Pointer<leveldb_options_t>);
typedef leveldb_options_destroy = Void Function(Pointer<leveldb_options_t>);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_comparator(leveldb_options_t*,
///                                                    leveldb_comparator_t*);
/// ```
typedef Leveldb_options_set_comparator = void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_comparator_t>,
);
typedef leveldb_options_set_comparator = Void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_comparator_t>,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_filter_policy(leveldb_options_t*,
///                                                       leveldb_filterpolicy_t*);
/// ```
typedef Leveldb_options_set_filter_policy = void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_filterpolicy_t>,
);
typedef leveldb_options_set_filter_policy = Void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_filterpolicy_t>,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_create_if_missing(leveldb_options_t*,
///                                                           uint8_t);
/// ```
typedef Leveldb_options_set_create_if_missing = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_create_if_missing = Void Function(
  Pointer<leveldb_options_t>,
  Uint8,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_error_if_exists(leveldb_options_t*,
///                                                         uint8_t);
/// ```
typedef Leveldb_options_set_error_if_exists = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_error_if_exists = Void Function(
  Pointer<leveldb_options_t>,
  Uint8,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_paranoid_checks(leveldb_options_t*,
///                                                         uint8_t);
/// ```
typedef Leveldb_options_set_paranoid_checks = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_paranoid_checks = Void Function(
  Pointer<leveldb_options_t>,
  Uint8,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_env(leveldb_options_t*, leveldb_env_t*);
/// ```
typedef Leveldb_options_set_env = void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_env_t>,
);
typedef leveldb_options_set_env = Void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_env_t>,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_info_log(leveldb_options_t*,
///                                                  leveldb_logger_t*);
/// ```
typedef Leveldb_options_set_info_log = void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_logger_t>,
);
typedef leveldb_options_set_info_log = Void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_logger_t>,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_write_buffer_size(leveldb_options_t*,
///                                                           size_t);
/// ```
typedef Leveldb_options_set_write_buffer_size = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_write_buffer_size = Void Function(
  Pointer<leveldb_options_t>,
  IntPtr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_max_open_files(leveldb_options_t*, int);
/// ```
typedef Leveldb_options_set_max_open_files = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_max_open_files = Void Function(
  Pointer<leveldb_options_t>,
  Int32,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_cache(leveldb_options_t*,
///                                               leveldb_cache_t*);
/// ```
typedef Leveldb_options_set_cache = void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_cache_t>,
);
typedef leveldb_options_set_cache = Void Function(
  Pointer<leveldb_options_t>,
  Pointer<leveldb_cache_t>,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_block_size(leveldb_options_t*, size_t);
/// ```
typedef Leveldb_options_set_block_size = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_block_size = Void Function(
  Pointer<leveldb_options_t>,
  IntPtr,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_block_restart_interval(
///    leveldb_options_t*, int);
/// ```
typedef Leveldb_options_set_block_restart_interval = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_block_restart_interval = Void Function(
  Pointer<leveldb_options_t>,
  Int32,
);

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_max_file_size(leveldb_options_t*,
///                                                       size_t);
/// ```
typedef Leveldb_options_set_max_file_size = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_max_file_size = Void Function(
  Pointer<leveldb_options_t>,
  IntPtr,
);

/// ```c
/// enum { leveldb_no_compression = 0, leveldb_snappy_compression = 1 };
/// ```
const leveldb_no_compression = 0;
const leveldb_snappy_compression = 1;

/// ```c
/// LEVELDB_EXPORT void leveldb_options_set_compression(leveldb_options_t*, int);
/// ```
typedef Leveldb_options_set_compression = void Function(
  Pointer<leveldb_options_t>,
  int,
);
typedef leveldb_options_set_compression = Void Function(
  Pointer<leveldb_options_t>,
  Uint32,
);
