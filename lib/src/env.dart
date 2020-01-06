import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:leveldb/src/native_wrapper.dart';
import 'library.dart';

abstract class Env extends NativeWrapper {
  /// Return a default environment suitable for the current operating
  /// system.  Sophisticated users may wish to provide their own Env
  /// implementation instead of relying on this default environment.
  ///
  /// The result of Default() belongs to leveldb and must never be deleted.
  factory Env.byDefault() => _Env(Lib.levelDB);
}

class _Env implements Env {
  final LibLevelDB lib;

  @override
  Pointer<leveldb_env_t> ptr;

  @override
  bool get isDisposed => ptr == null || ptr == nullptr;

  _Env(this.lib) : ptr = lib.leveldbCreateDefaultEnv();

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbEnvDestroy(ptr);
    ptr = nullptr;
  }
}
