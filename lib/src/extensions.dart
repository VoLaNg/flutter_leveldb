import 'package:leveldb/interop/interop.dart';

import 'options.dart';

extension NativeCompressionType on CompressionType {
  int toNative() {
    switch (this) {
      case CompressionType.none:
        return leveldb_no_compression;
      case CompressionType.snappy:
        return leveldb_snappy_compression;
    }
    throw Error(); // Unimplemented case
  }
}

extension NativeBool on bool {
  int toNative() => this ? 1 : 0;
}
