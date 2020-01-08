import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:leveldb/interop/interop.dart';

import 'native_wrapper.dart';
import 'options.dart';

extension NativeCompressionType on CompressionType {
  int associatedValue() {
    switch (this) {
      case CompressionType.none:
        return leveldb_no_compression;
      case CompressionType.snappy:
        return leveldb_snappy_compression;
    }
    throw Error(); // Unimplemented case
  }
}

extension Bool on bool {
  int toInt() => this ? 1 : 0;
}

extension DisposableExtension on DisposablePointer {
  /// if true - the pointer (ptr) can't be accessed or modified
  // ignore: invalid_use_of_protected_member
  bool get isDisposed => ptr == null || ptr == nullptr;

  void attemptTo(String funcName) {
    if (!isDisposed) return;
    throw StateError(
      'Attempt to [$funcName] when [$runtimeType.isDisposed] == true',
    );
  }
}

extension BytesPointer on Pointer<Uint8> {
  // TODO: https://github.com/dart-lang/sdk/issues/35763
  static Pointer<Uint8> fromList(Uint8List lst) {
    final Pointer<Uint8> ptr = allocate(count: lst.lengthInBytes);
    final newLst = ptr.asTypedList(lst.length);
    newLst.setAll(0, lst);
    return ptr;
  }
}
