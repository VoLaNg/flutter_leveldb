import 'dart:ffi';

import 'package:ffi/ffi.dart';
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
  final Pointer<leveldb_env_t> _ptr;

  @override
  Pointer<leveldb_env_t> get ptr => isDestroyed ? null : _ptr;

  @override
  bool isDestroyed;

  _Env(this.lib) : _ptr = lib.leveldbCreateDefaultEnv();

  @override
  void destroy() {
    if (isDestroyed) return;
    isDestroyed = true;
    lib.leveldbEnvDestroy(ptr);
    free(_ptr);
  }
}
