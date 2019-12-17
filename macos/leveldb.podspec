#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint leveldb.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'leveldb'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Kirill Minakovskiy' => 'minakovsky.kirill@gmail.com' }
  s.source           = { :path => '.' }
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.swift_version = '5.0'
  
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES',
    'LIBRARY_STYLE' => 'STATIC',
    'SYMROOT' => '${PODS_TARGET_SRCROOT}',
    'GCC_GENERATE_DEBUGGING_SYMBOLS' => 'NO',
    'GCC_INLINES_ARE_PRIVATE_EXTERN' => 'NO',
    'GCC_OPTIMIZATION_LEVEL' => 's',
    # TODO: Add HAVE_CRC32C and HAVE_SNAPPY
    # LEVELDB_COMPILE_LIBRARY && LEVELDB_SHARED_LIBRARY adds __attribute__((visibility("default"))) for all exposed C functions.
    # what allowing to add -fvisibility=hidden
    # https://github.com/google/leveldb/blob/6caf73ad9dae0ee91873bcb39554537b85163770/include/leveldb/export.h
    'GCC_PREPROCESSOR_DEFINITIONS' => "$(inherited) 'LEVELDB_PLATFORM_POSIX=1' LEVELDB_SHARED_LIBRARY LEVELDB_COMPILE_LIBRARY 'LEVELDB_IS_BIG_ENDIAN=0'",
    'CFLAGS' => '-D_DARWIN_SOURCE',
    # -Wstrict-prototypes - Enable strict prototype warnings for C code in clang and gcc
    # -Wthread-safety - https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
    # -fno-exceptions - Disable C++ exceptions.
    # ? Does flutter use RTTI on typecasting? https://docs.microsoft.com/en-us/cpp/cpp/run-time-type-information
    # -fno-rtti - Disable RTTI (Run-Time Type Information).
    # -fvisibility=hidden - https://gcc.gnu.org/wiki/Visibility. Requires adding attributes on exposed (C) functions: https://flutter.dev/docs/development/platform-integration/c-interop#source-code
    'OTHER_CFLAGS' => '$(inherited) -Wstrict-prototypes -Wthread-safety -fno-exceptions -fno-rtti -fno-omit-frame-pointer -fvisibility=hidden',
    'OTHER_CPLUSPLUSFLAGS' => '$(inherited) -std=c++11 -momit-leaf-frame-pointer -DNDEBUG $(OTHER_CFLAGS)',
    'GCC_SYMBOLS_PRIVATE_EXTERN' => 'NO',
    'SKIP_INSTALL' => 'YES',
    
    # Search Paths
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/../Flutter" "/Library/Frameworks"',
    'SYSTEM_HEADER_SEARCH_PATHS' => '$(inherited) "${PODS_TARGET_SRCROOT}/leveldb/helpers/memenv/"',
    'HEADER_SEARCH_PATHS' => '$(inherited) "${PODS_TARGET_SRCROOT}/leveldb/include/" "${PODS_TARGET_SRCROOT}/leveldb/."',
    'USE_HEADERMAP' => 'NO'
  }

  s.source_files = 
  'leveldb/db/builder.cc',
  'leveldb/db/c.cc',
  'leveldb/db/db_impl.cc',
  'leveldb/db/db_iter.cc',
  'leveldb/db/dbformat.cc',
  'leveldb/db/dumpfile.cc',
  'leveldb/db/filename.cc',
  'leveldb/db/leveldbutil.cc',
  'leveldb/db/log_reader.cc',
  'leveldb/db/log_writer.cc',
  'leveldb/db/memtable.cc',
  'leveldb/db/repair.cc',
  'leveldb/db/table_cache.cc',
  'leveldb/db/version_edit.cc',
  'leveldb/db/version_set.cc',
  'leveldb/db/write_batch.cc',
  'leveldb/table/block_builder.cc',
  'leveldb/table/block.cc',
  'leveldb/table/filter_block.cc',
  'leveldb/table/format.cc',
  'leveldb/table/iterator.cc',
  'leveldb/table/merger.cc',
  'leveldb/table/table_builder.cc',
  'leveldb/table/table.cc',
  'leveldb/table/two_level_iterator.cc',
  'leveldb/util/arena.cc',
  'leveldb/util/bloom.cc',
  'leveldb/util/cache.cc',
  'leveldb/util/coding.cc',
  'leveldb/util/comparator.cc',
  'leveldb/util/crc32c.cc',
  'leveldb/util/env_posix.cc',
  'leveldb/util/env.cc',
  'leveldb/util/filter_policy.cc',
  'leveldb/util/hash.cc',
  'leveldb/util/logging.cc',
  'leveldb/util/options.cc',
  'leveldb/util/status.cc',
  'Classes/**/*.swift'  # -fvisibility=hidden will hide all Objective-C code.
end
