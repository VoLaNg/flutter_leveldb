import 'dart:ffi';
import 'package:meta/meta.dart';

abstract class NativeWrapper<T extends NativeType> {
  @protected
  Pointer<T> get ptr;

  void dispose();
}
