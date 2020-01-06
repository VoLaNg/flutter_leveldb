import 'dart:ffi';
import 'package:meta/meta.dart';

abstract class NativeWrapper<T extends NativeType> {
  @protected
  Pointer<T> get ptr;

  /// if true - the pointer (ptr) can't be accessed or modified
  bool get isDisposed => ptr == null || ptr == nullptr;

  void dispose();
}
