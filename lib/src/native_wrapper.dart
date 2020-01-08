import 'dart:ffi';
import 'package:meta/meta.dart';

// TODO: https://github.com/dart-lang/sdk/issues/35770
abstract class DisposablePointer<T extends NativeType> {
  @protected
  Pointer<T> get ptr;

  void dispose();
}

abstract class AnyStructure extends DisposablePointer {}
