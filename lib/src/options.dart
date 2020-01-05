import 'dart:ffi';
import 'package:leveldb/interop/interop.dart' show leveldb_options_t;
import 'package:meta/meta.dart';

import 'cache.dart';
import 'comparator.dart';
import 'env.dart';
import 'filter_policy.dart';
import 'native_wrapper.dart';

/// Options to control the behavior of a database (passed to [LevelDB.open])
abstract class Options extends NativeWrapper {
  /// Create an Options object with default values for all fields.
  // !: factory Options.byDefault() => _Options();

  /// Comparator used to define the order of keys in the table.
  /// Default: a comparator that uses lexicographic byte-wise ordering
  ///
  /// REQUIRES: The client must ensure that the comparator supplied
  /// here has the same name and orders keys *exactly* the same as the
  /// comparator provided to previous open calls on the same DB.
  final Comparator comparator = null;
  // !: make sure null is not sent to leveldb_options_t

  /// If non-null, use the specified filter policy to reduce disk reads.
  /// Many applications will benefit from passing the result of
  /// [FilterPolicy.bloom()] here.
  final FilterPolicy filterPolicy = null;

  /// If true, the database will be created if it is missing.
  final bool createIfMissing = false;

  /// If true, an error is raised if the database already exists.
  final bool errorIfExists = false;

  /// If true, the implementation will do aggressive checking of the
  /// data it is processing and will stop early if it detects any
  /// errors.  This may have unforeseen ramifications: for example, a
  /// corruption of one DB entry may cause a large number of entries to
  /// become unreadable or for the entire DB to become unopenable.
  final bool paranoidChecks = false;

  /// Use the specified object to interact with the environment,
  /// e.g. to read/write files, schedule background work, etc.
  /// Default: [Env.byDefault]
  final Env env = Env.byDefault();

  // -------------------
  // Parameters that affect performance

  /// Amount of data to build up in memory (backed by an unsorted log
  /// on disk) before converting to a sorted on-disk file.
  ///
  /// Larger values increase performance, especially during bulk loads.
  /// Up to two write buffers may be held in memory at the same time,
  /// so you may wish to adjust this parameter to control memory usage.
  /// Also, a larger write buffer will result in a longer recovery time
  /// the next time the database is opened.
  final int writeBufferSize = 4 * 1024 * 1024;

  /// Number of open files that can be used by the DB.  You may need to
  /// increase this if your database has a large working set (budget
  /// one open file per 2MB of working set).
  final int maxOpenFiles = 1000;

  /// Control over blocks (user data is stored in a set of blocks, and
  /// a block is the unit of reading from disk).
  ///
  /// If non-null, use the specified cache for blocks.
  /// If null, leveldb will automatically create and use an 8MB internal cache.
  final Cache blockCache = null;

  /// Approximate size of user data packed per block.  Note that the
  /// block size specified here corresponds to uncompressed data.  The
  /// actual size of the unit read from disk may be smaller if
  /// compression is enabled.  This parameter can be changed dynamically.
  int blockSize = 4 * 1024;

  /// Number of keys between restart points for delta encoding of keys.
  /// This parameter can be changed dynamically.  Most clients should
  /// leave this parameter alone.
  int blockRestartInterval = 16;

  /// Leveldb will write up to this amount of bytes to a file before
  /// switching to a new one.
  /// Most clients should leave this parameter alone.  However if your
  /// filesystem is more efficient with larger files, you could
  /// consider increasing the value.  The downside will be longer
  /// compactions and hence longer latency/performance hiccups.
  /// Another reason to increase this parameter might be when you are
  /// initially populating a large database.
  final int maxFileSize = 2 * 1024 * 1024;

  /// Compress blocks using the specified compression algorithm.  This
  /// parameter can be changed dynamically.
  ///
  /// Default: [CompressionType.snappy], which gives lightweight but fast
  /// compression.
  ///
  /// Typical speeds of [CompressionType.snappy] on an Intel(R) Core(TM)2 2.4GHz:
  ///    ~200-500MB/s compression
  ///    ~400-800MB/s decompression
  /// Note that these speeds are significantly faster than most
  /// persistent storage speeds, and therefore it is typically never
  /// worth switching to kNoCompression.  Even if the input data is
  /// incompressible, the [CompressionType.snappy] implementation will
  /// efficiently detect that and will switch to uncompressed mode.
  final CompressionType compressionType = CompressionType.snappy;

  @override
  @protected
  Pointer<leveldb_options_t> get ptr;
}

enum CompressionType { none, snappy }
