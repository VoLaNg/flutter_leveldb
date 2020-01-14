import 'dart:ffi';

import 'package:leveldb/interop/interop.dart';
import 'package:meta/meta.dart';
import 'extensions.dart';
import 'library.dart';
import 'native_wrapper.dart';

abstract class Env extends AnyStructure {
  /// Return a default environment suitable for the current operating
  /// system.  Sophisticated users may wish to provide their own Env
  /// implementation instead of relying on this default environment.
  ///
  /// The result of Default() belongs to leveldb and must never be deleted.
  factory Env.byDefault([@visibleForTesting LibLevelDB lib]) =>
      _Env(lib ?? Lib.levelDB);
}

class _Env implements Env {
  final LibLevelDB lib;

  @override
  Pointer<leveldb_env_t> ptr;

  _Env(this.lib) : ptr = lib.leveldbCreateDefaultEnv();

  @override
  void dispose() {
    if (isDisposed) return;
    lib.leveldbEnvDestroy(ptr);
    ptr = nullptr;
  }
}
