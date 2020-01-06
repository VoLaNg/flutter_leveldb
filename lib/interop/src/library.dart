import 'dart:ffi';

import 'leveldb_cache_t.dart';
import 'leveldb_comparator_t.dart';
import 'leveldb_env_t.dart';
import 'leveldb_filterpolicy_t.dart';
import 'leveldb_iterator_t.dart';
import 'leveldb_options_t.dart';
import 'leveldb_readoptions_t.dart';
import 'leveldb_snapshot_t.dart';
import 'leveldb_t.dart';
import 'leveldb_writebatch_t.dart';
import 'leveldb_writeoptions_t.dart';

abstract class LibLevelDB {
  factory LibLevelDB.lookupLib(DynamicLibrary lib) => _LibLevelDB(lib);
  // ?: factory LibLevelDB.lazyLookupLib(DynamicLibrary lib) => _LazyLibLevelDB(lib);

  Leveldb_open get leveldbOpen;
  Leveldb_close get leveldbClose;
  Leveldb_put get leveldbPut;
  Leveldb_delete get leveldbDelete;
  Leveldb_write get leveldbWrite;
  Leveldb_get get leveldbGet;
  Leveldb_property_value get leveldbPropertyValue;
  Leveldb_approximate_sizes get leveldbApproximateSizes;
  Leveldb_compact_range get leveldbCompactRange;
  Leveldb_destroy_db get leveldbDestroyDb;
  Leveldb_repair_db get leveldbRepairDb;
  Leveldb_free get leveldbFree;
  Leveldb_major_version get leveldbMajorVersion;
  Leveldb_minor_version get leveldbMinorVersion;
  // LevelDB Snapshot
  Leveldb_create_snapshot get leveldbCreateSnapshot;
  Leveldb_release_snapshot get leveldbReleaseSnapshot;
  // LevelDB Options
  Leveldb_options_create get leveldbOptionsCreate;
  Leveldb_options_destroy get leveldbOptionsDestroy;
  Leveldb_options_set_comparator get leveldbOptionsSetComparator;
  Leveldb_options_set_filter_policy get leveldbOptionsSetFilterPolicy;
  Leveldb_options_set_create_if_missing get leveldbOptionsSetCreateIfMissing;
  Leveldb_options_set_error_if_exists get leveldbOptionsSetErrorIfExists;
  Leveldb_options_set_paranoid_checks get leveldbOptionsSetParanoidChecks;
  Leveldb_options_set_env get leveldbOptionsSetEnv;
  Leveldb_options_set_info_log get leveldbOptionsSetInfoLog;
  Leveldb_options_set_write_buffer_size get leveldbOptionsSetWriteBufferSize;
  Leveldb_options_set_max_open_files get leveldbOptionsSetMaxOpenFiles;
  Leveldb_options_set_cache get leveldbOptionsSetCache;
  Leveldb_options_set_block_size get leveldbOptionsSetBlockSize;
  Leveldb_options_set_block_restart_interval
      get leveldbOptionsSetBlockRestartInterval;
  Leveldb_options_set_max_file_size get leveldbOptionsSetMaxFileSize;
  Leveldb_options_set_compression get leveldbOptionsSetCompression;
  // LevelDB Read Options
  Leveldb_readoptions_create get leveldbReadoptionsCreate;
  Leveldb_readoptions_destroy get leveldbReadoptionsDestroy;
  Leveldb_readoptions_set_verify_checksums
      get leveldbReadoptionsSetVerifyChecksums;
  Leveldb_readoptions_set_fill_cache get leveldbReadoptionsSetFillCache;
  Leveldb_readoptions_set_snapshot get leveldbReadoptionsSetSnapshot;
  // LevelDB Write Options
  Leveldb_writeoptions_create get leveldbWriteoptionsCreate;
  Leveldb_writeoptions_destroy get leveldbWriteoptionsDestroy;
  Leveldb_writeoptions_set_sync get leveldbWriteoptionsSetSync;
  // LevelDB Cache
  Leveldb_cache_destroy get leveldbCacheDestroy;
  Leveldb_cache_create_lru get leveldbCacheCreateLru;
  // LevelDB Env
  Leveldb_create_default_env get leveldbCreateDefaultEnv;
  Leveldb_env_destroy get leveldbEnvDestroy;
  // LevelDB Filter Policy
  Leveldb_filterpolicy_create get leveldbFilterpolicyCreate;
  Leveldb_filterpolicy_destroy get leveldbFilterpolicyDestroy;
  Leveldb_filterpolicy_create_bloom get leveldbFilterpolicyCreateBloom;
  // LevelDB Comparator
  Leveldb_comparator_create get leveldbComparatorCreate;
  Leveldb_comparator_destroy get leveldbComparatorDestroy;
  // LevelDB Iterator
  Leveldb_create_iterator get leveldbCreateIterator;
  Leveldb_iter_destroy get leveldbIterDestroy;
  Leveldb_iter_valid get leveldbIterValid;
  Leveldb_iter_seek_to_first get leveldbIterSeekToFirst;
  Leveldb_iter_seek_to_last get leveldbIterSeekToLast;
  Leveldb_iter_seek get leveldbIterSeek;
  Leveldb_iter_next get leveldbIterNext;
  Leveldb_iter_prev get leveldbIterPrev;
  Leveldb_iter_key get leveldbIterKey;
  Leveldb_iter_value get leveldbIterValue;
  Leveldb_iter_get_error get leveldbIterGetError;
  // LevelDB Write batch
  Leveldb_writebatch_create get leveldbWritebatchCreate;
  Leveldb_writebatch_destroy get leveldbWritebatchDestroy;
  Leveldb_writebatch_clear get leveldbWritebatchClear;
  Leveldb_writebatch_put get leveldbWritebatchPut;
  Leveldb_writebatch_delete get leveldbWritebatchDelete;
  Leveldb_writebatch_iterate get leveldbWritebatchIterate;
  Leveldb_writebatch_append get leveldbWritebatchAppend;
}

class _LibLevelDB implements LibLevelDB {
  final DynamicLibrary lib;

  final Leveldb_open leveldbOpen;
  final Leveldb_close leveldbClose;
  final Leveldb_put leveldbPut;
  final Leveldb_delete leveldbDelete;
  final Leveldb_write leveldbWrite;
  final Leveldb_get leveldbGet;
  final Leveldb_property_value leveldbPropertyValue;
  final Leveldb_approximate_sizes leveldbApproximateSizes;
  final Leveldb_compact_range leveldbCompactRange;
  final Leveldb_destroy_db leveldbDestroyDb;
  final Leveldb_repair_db leveldbRepairDb;
  final Leveldb_free leveldbFree;
  final Leveldb_major_version leveldbMajorVersion;
  final Leveldb_minor_version leveldbMinorVersion;
  // LevelDB Snapshot
  final Leveldb_create_snapshot leveldbCreateSnapshot;
  final Leveldb_release_snapshot leveldbReleaseSnapshot;
  // LevelDB Options
  final Leveldb_options_create leveldbOptionsCreate;
  final Leveldb_options_destroy leveldbOptionsDestroy;
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
  // LevelDB Read Options
  final Leveldb_readoptions_create leveldbReadoptionsCreate;
  final Leveldb_readoptions_destroy leveldbReadoptionsDestroy;
  final Leveldb_readoptions_set_verify_checksums
      leveldbReadoptionsSetVerifyChecksums;
  final Leveldb_readoptions_set_fill_cache leveldbReadoptionsSetFillCache;
  final Leveldb_readoptions_set_snapshot leveldbReadoptionsSetSnapshot;
  // LevelDB Write Options
  final Leveldb_writeoptions_create leveldbWriteoptionsCreate;
  final Leveldb_writeoptions_destroy leveldbWriteoptionsDestroy;
  final Leveldb_writeoptions_set_sync leveldbWriteoptionsSetSync;
  // LevelDB Cache
  final Leveldb_cache_destroy leveldbCacheDestroy;
  final Leveldb_cache_create_lru leveldbCacheCreateLru;
  // LevelDB Env
  final Leveldb_create_default_env leveldbCreateDefaultEnv;
  final Leveldb_env_destroy leveldbEnvDestroy;
  // LevelDB Filter Policy
  final Leveldb_filterpolicy_create leveldbFilterpolicyCreate;
  final Leveldb_filterpolicy_destroy leveldbFilterpolicyDestroy;
  final Leveldb_filterpolicy_create_bloom leveldbFilterpolicyCreateBloom;
  // LevelDB Comparator
  final Leveldb_comparator_create leveldbComparatorCreate;
  final Leveldb_comparator_destroy leveldbComparatorDestroy;
  // LevelDB Iterator
  final Leveldb_create_iterator leveldbCreateIterator;
  final Leveldb_iter_destroy leveldbIterDestroy;
  final Leveldb_iter_valid leveldbIterValid;
  final Leveldb_iter_seek_to_first leveldbIterSeekToFirst;
  final Leveldb_iter_seek_to_last leveldbIterSeekToLast;
  final Leveldb_iter_seek leveldbIterSeek;
  final Leveldb_iter_next leveldbIterNext;
  final Leveldb_iter_prev leveldbIterPrev;
  final Leveldb_iter_key leveldbIterKey;
  final Leveldb_iter_value leveldbIterValue;
  final Leveldb_iter_get_error leveldbIterGetError;
  // LevelDB Write batch
  final Leveldb_writebatch_create leveldbWritebatchCreate;
  final Leveldb_writebatch_destroy leveldbWritebatchDestroy;
  final Leveldb_writebatch_clear leveldbWritebatchClear;
  final Leveldb_writebatch_put leveldbWritebatchPut;
  final Leveldb_writebatch_delete leveldbWritebatchDelete;
  final Leveldb_writebatch_iterate leveldbWritebatchIterate;
  final Leveldb_writebatch_append leveldbWritebatchAppend;

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
        leveldbPropertyValue = lib
            .lookup<NativeFunction<leveldb_property_value>>(
                'leveldb_property_value')
            .asFunction(),
        leveldbApproximateSizes = lib
            .lookup<NativeFunction<leveldb_approximate_sizes>>(
                'leveldb_approximate_sizes')
            .asFunction(),
        leveldbCompactRange = lib
            .lookup<NativeFunction<leveldb_compact_range>>(
                'leveldb_compact_range')
            .asFunction(),
        leveldbDestroyDb = lib
            .lookup<NativeFunction<leveldb_destroy_db>>('leveldb_destroy_db')
            .asFunction(),
        leveldbRepairDb = lib
            .lookup<NativeFunction<leveldb_repair_db>>('leveldb_repair_db')
            .asFunction(),
        leveldbFree = lib
            .lookup<NativeFunction<leveldb_free>>('leveldb_free')
            .asFunction(),
        leveldbMajorVersion = lib
            .lookup<NativeFunction<leveldb_major_version>>(
                'leveldb_major_version')
            .asFunction(),
        leveldbMinorVersion = lib
            .lookup<NativeFunction<leveldb_minor_version>>(
                'leveldb_minor_version')
            .asFunction(),
        // Snapshot
        leveldbCreateSnapshot = lib
            .lookup<NativeFunction<leveldb_create_snapshot>>(
                'leveldb_create_snapshot')
            .asFunction(),
        leveldbReleaseSnapshot = lib
            .lookup<NativeFunction<leveldb_release_snapshot>>(
                'leveldb_release_snapshot')
            .asFunction(),
        // LevelDB Options
        leveldbOptionsCreate = lib
            .lookup<NativeFunction<leveldb_options_create>>(
                'leveldb_options_create')
            .asFunction(),
        leveldbOptionsDestroy = lib
            .lookup<NativeFunction<leveldb_options_destroy>>(
                'leveldb_options_destroy')
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
            .asFunction(),
        // LevelDB Read Options
        leveldbReadoptionsCreate = lib
            .lookup<NativeFunction<leveldb_readoptions_create>>(
                'leveldb_readoptions_create')
            .asFunction(),
        leveldbReadoptionsDestroy = lib
            .lookup<NativeFunction<leveldb_readoptions_destroy>>(
                'leveldb_readoptions_destroy')
            .asFunction(),
        leveldbReadoptionsSetVerifyChecksums = lib
            .lookup<NativeFunction<leveldb_readoptions_set_verify_checksums>>(
                'leveldb_readoptions_set_verify_checksums')
            .asFunction(),
        leveldbReadoptionsSetFillCache = lib
            .lookup<NativeFunction<leveldb_readoptions_set_fill_cache>>(
                'leveldb_readoptions_set_fill_cache')
            .asFunction(),
        leveldbReadoptionsSetSnapshot = lib
            .lookup<NativeFunction<leveldb_readoptions_set_snapshot>>(
                'leveldb_readoptions_set_snapshot')
            .asFunction(),
        // LevelDB Write Options
        leveldbWriteoptionsCreate = lib
            .lookup<NativeFunction<leveldb_writeoptions_create>>(
                'leveldb_writeoptions_create')
            .asFunction(),
        leveldbWriteoptionsDestroy = lib
            .lookup<NativeFunction<leveldb_writeoptions_destroy>>(
                'leveldb_writeoptions_destroy')
            .asFunction(),
        leveldbWriteoptionsSetSync = lib
            .lookup<NativeFunction<leveldb_writeoptions_set_sync>>(
                'leveldb_writeoptions_set_sync')
            .asFunction(),
        // Cache
        leveldbCacheCreateLru = lib
            .lookup<NativeFunction<leveldb_cache_create_lru>>(
                'leveldb_cache_create_lru')
            .asFunction(),
        leveldbCacheDestroy = lib
            .lookup<NativeFunction<leveldb_cache_destroy>>(
                'leveldb_cache_destroy')
            .asFunction(),
        // Env
        leveldbCreateDefaultEnv = lib
            .lookup<NativeFunction<leveldb_create_default_env>>(
                'leveldb_create_default_env')
            .asFunction(),
        leveldbEnvDestroy = lib
            .lookup<NativeFunction<leveldb_env_destroy>>('leveldb_env_destroy')
            .asFunction(),
        // Filter policy
        leveldbFilterpolicyCreate = lib
            .lookup<NativeFunction<leveldb_filterpolicy_create>>(
                'leveldb_filterpolicy_create')
            .asFunction(),
        leveldbFilterpolicyDestroy = lib
            .lookup<NativeFunction<leveldb_filterpolicy_destroy>>(
                'leveldb_filterpolicy_destroy')
            .asFunction(),
        leveldbFilterpolicyCreateBloom = lib
            .lookup<NativeFunction<leveldb_filterpolicy_create_bloom>>(
                'leveldb_filterpolicy_create_bloom')
            .asFunction(),
        leveldbComparatorCreate = lib
            .lookup<NativeFunction<leveldb_comparator_create>>(
                'leveldb_comparator_create')
            .asFunction(),
        leveldbComparatorDestroy = lib
            .lookup<NativeFunction<leveldb_comparator_destroy>>(
                'leveldb_comparator_destroy')
            .asFunction(),
        // Iterator
        leveldbCreateIterator = lib
            .lookup<NativeFunction<leveldb_create_iterator>>(
                'leveldb_create_iterator')
            .asFunction(),
        leveldbIterDestroy = lib
            .lookup<NativeFunction<leveldb_iter_destroy>>(
                'leveldb_iter_destroy')
            .asFunction(),
        leveldbIterValid = lib
            .lookup<NativeFunction<leveldb_iter_valid>>('leveldb_iter_valid')
            .asFunction(),
        leveldbIterSeekToFirst = lib
            .lookup<NativeFunction<leveldb_iter_seek_to_first>>(
                'leveldb_iter_seek_to_first')
            .asFunction(),
        leveldbIterSeekToLast = lib
            .lookup<NativeFunction<leveldb_iter_seek_to_last>>(
                'leveldb_iter_seek_to_last')
            .asFunction(),
        leveldbIterSeek = lib
            .lookup<NativeFunction<leveldb_iter_seek>>('leveldb_iter_seek')
            .asFunction(),
        leveldbIterNext = lib
            .lookup<NativeFunction<leveldb_iter_next>>('leveldb_iter_next')
            .asFunction(),
        leveldbIterPrev = lib
            .lookup<NativeFunction<leveldb_iter_prev>>('leveldb_iter_prev')
            .asFunction(),
        leveldbIterKey = lib
            .lookup<NativeFunction<leveldb_iter_key>>('leveldb_iter_key')
            .asFunction(),
        leveldbIterValue = lib
            .lookup<NativeFunction<leveldb_iter_value>>('leveldb_iter_value')
            .asFunction(),
        leveldbIterGetError = lib
            .lookup<NativeFunction<leveldb_iter_get_error>>(
                'leveldb_iter_get_error')
            .asFunction(),
        // Write batch
        leveldbWritebatchCreate = lib
            .lookup<NativeFunction<leveldb_writebatch_create>>(
                'leveldb_writebatch_create')
            .asFunction(),
        leveldbWritebatchDestroy = lib
            .lookup<NativeFunction<leveldb_writebatch_destroy>>(
                'leveldb_writebatch_destroy')
            .asFunction(),
        leveldbWritebatchClear = lib
            .lookup<NativeFunction<leveldb_writebatch_clear>>(
                'leveldb_writebatch_clear')
            .asFunction(),
        leveldbWritebatchPut = lib
            .lookup<NativeFunction<leveldb_writebatch_put>>(
                'leveldb_writebatch_put')
            .asFunction(),
        leveldbWritebatchDelete = lib
            .lookup<NativeFunction<leveldb_writebatch_delete>>(
                'leveldb_writebatch_delete')
            .asFunction(),
        leveldbWritebatchIterate = lib
            .lookup<NativeFunction<leveldb_writebatch_iterate>>(
                'leveldb_writebatch_iterate')
            .asFunction(),
        leveldbWritebatchAppend = lib
            .lookup<NativeFunction<leveldb_writebatch_append>>(
                'leveldb_writebatch_append')
            .asFunction();
}
