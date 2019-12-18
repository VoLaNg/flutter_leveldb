import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'leveldb_options_t.dart';
import 'leveldb_t.dart';

abstract class LibLevelDB {
  factory LibLevelDB.lookupLib(DynamicLibrary lib) => _LibLevelDB(lib);
  // ?: factory LibLevelDB.lazyLookupLib(DynamicLibrary lib) => _LazyLibLevelDB(lib);
}

class _LibLevelDB implements LibLevelDB {
  final DynamicLibrary lib;

  final Leveldb_open leveldbOpen;
  final Leveldb_close leveldbClose;
  final Leveldb_put leveldbPut;
  final Leveldb_delete leveldbDelete;
  final Leveldb_write leveldbWrite;
  final Leveldb_get leveldbGet;
  // LevelDB Options
  final Leveldb_options_create leveldbOptionsCreate;
  final Leveldb_options_set_comparator leveldbOptionsSetComparator;
  final Leveldb_options_set_filter_policy leveldbOptionsSetFilterPolicy;
  final Leveldb_options_set_create_if_missing leveldbOptionsSetCreateIfMissing;
  final Leveldb_options_set_error_if_exists leveldbOptionsSetErrorIfExists;
  final Leveldb_options_set_paranoid_checks leveldbOptionsSetParanoidChecks;
  final Leveldb_options_set_env leveldbOptionsSetEnv;
  final Leveldb_options_set_info_log leveldbOptionsSetInfoLog;
  final Leveldb_options_set_write_buffer_size leveldbOptionsSetWriteBufferSize;
  final Leveldb_options_set_max_open_files leveldbOptionsSetMaxOpenFiles;
  final Leveldb_options_set_cache leveldbOptionsSetCache;
  final Leveldb_options_set_block_size leveldbOptionsSetBlockSize;
  final Leveldb_options_set_block_restart_interval
      leveldbOptionsSetBlockRestartInterval;
  final Leveldb_options_set_max_file_size leveldbOptionsSetMaxFileSize;
  final Leveldb_options_set_compression leveldbOptionsSetCompression;

  _LibLevelDB(this.lib)
      : leveldbOpen = lib
            .lookup<NativeFunction<leveldb_open>>('leveldb_open')
            .asFunction(),
        leveldbClose = lib
            .lookup<NativeFunction<leveldb_close>>('leveldb_close')
            .asFunction(),
        leveldbPut =
            lib.lookup<NativeFunction<leveldb_put>>('leveldb_put').asFunction(),
        leveldbDelete = lib
            .lookup<NativeFunction<leveldb_delete>>('leveldb_delete')
            .asFunction(),
        leveldbWrite = lib
            .lookup<NativeFunction<leveldb_write>>('leveldb_write')
            .asFunction(),
        leveldbGet =
            lib.lookup<NativeFunction<leveldb_get>>('leveldb_get').asFunction(),
        // LevelDB Options
        leveldbOptionsCreate = lib
            .lookup<NativeFunction<leveldb_options_create>>(
                'leveldb_options_create')
            .asFunction(),
        leveldbOptionsSetComparator = lib
            .lookup<NativeFunction<leveldb_options_set_comparator>>(
                'leveldb_options_set_comparator')
            .asFunction(),
        leveldbOptionsSetFilterPolicy = lib
            .lookup<NativeFunction<leveldb_options_set_filter_policy>>(
                'leveldb_options_set_filter_policy')
            .asFunction(),
        leveldbOptionsSetCreateIfMissing = lib
            .lookup<NativeFunction<leveldb_options_set_create_if_missing>>(
                'leveldb_options_set_create_if_missing')
            .asFunction(),
        leveldbOptionsSetErrorIfExists = lib
            .lookup<NativeFunction<leveldb_options_set_error_if_exists>>(
                'leveldb_options_set_error_if_exists')
            .asFunction(),
        leveldbOptionsSetParanoidChecks = lib
            .lookup<NativeFunction<leveldb_options_set_paranoid_checks>>(
                'leveldb_options_set_paranoid_checks')
            .asFunction(),
        leveldbOptionsSetEnv = lib
            .lookup<NativeFunction<leveldb_options_set_env>>(
                'leveldb_options_set_env')
            .asFunction(),
        leveldbOptionsSetInfoLog = lib
            .lookup<NativeFunction<leveldb_options_set_info_log>>(
                'leveldb_options_set_info_log')
            .asFunction(),
        leveldbOptionsSetWriteBufferSize = lib
            .lookup<NativeFunction<leveldb_options_set_write_buffer_size>>(
                'leveldb_options_set_write_buffer_size')
            .asFunction(),
        leveldbOptionsSetMaxOpenFiles = lib
            .lookup<NativeFunction<leveldb_options_set_max_open_files>>(
                'leveldb_options_set_max_open_files')
            .asFunction(),
        leveldbOptionsSetCache = lib
            .lookup<NativeFunction<leveldb_options_set_cache>>(
                'leveldb_options_set_cache')
            .asFunction(),
        leveldbOptionsSetBlockSize = lib
            .lookup<NativeFunction<leveldb_options_set_block_size>>(
                'leveldb_options_set_block_size')
            .asFunction(),
        leveldbOptionsSetBlockRestartInterval = lib
            .lookup<NativeFunction<leveldb_options_set_block_restart_interval>>(
                'leveldb_options_set_block_restart_interval')
            .asFunction(),
        leveldbOptionsSetMaxFileSize = lib
            .lookup<NativeFunction<leveldb_options_set_max_file_size>>(
                'leveldb_options_set_max_file_size')
            .asFunction(),
        leveldbOptionsSetCompression = lib
            .lookup<NativeFunction<leveldb_options_set_compression>>(
                'leveldb_options_set_compression')
            .asFunction();
}
