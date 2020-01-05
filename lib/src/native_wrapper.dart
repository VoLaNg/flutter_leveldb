import 'dart:ffi';
import 'package:meta/meta.dart';

abstract class NativeWrapper<T extends NativeType> {
  @protected
  Pointer<T> get ptr;

  /// if false - the pointer (ptr) can't be accessed or modified
  bool get isDestroyed;

  /// destroys the pointer (ptr)
  void destroy();
}
