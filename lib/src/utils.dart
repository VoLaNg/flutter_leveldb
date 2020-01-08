import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:leveldb/src/exceptions.dart';

T allocctx<T, U extends NativeType>(
  T Function(Pointer<U> v) f, [
  Pointer<U> Function() allocationFunction = allocate,
  void Function(Pointer<U>) freeFunction = free,
]) {
  final Pointer<U> v = allocationFunction();
  T result;
  try {
    result = f(v);
  } catch (e) {
    freeFunction(v);
    rethrow;
  }
  freeFunction(v);
  return result;
}

// TODO: return null when errptr == 'Status::IsNotFound()'
T errorHandler<T>(T Function(Pointer<Pointer<Utf8>> errptr) f) {
  final Pointer<Pointer<Utf8>> errptr = allocate();
  errptr.value = nullptr;

  T result;
  try {
    result = f(errptr);
  } catch (e) {
    final exception = _tryParseError(errptr);
    free(errptr);
    if ((exception != null) && (exception is LevelDBException)) {
      throw LevelDBException.combined(e, exception);
    } else {
      rethrow;
    }
  }

  final exception = _tryParseError(errptr);
  free(errptr);

  if (exception != null) {
    throw exception;
  }

  return result;
}

Exception _tryParseError(Pointer<Pointer<Utf8>> errptr) {
  if (errptr.value == nullptr) return null;
  try {
    return LevelDBException.errptr(Utf8.fromUtf8(errptr.value));
  } catch (e) {
    return e;
  }
}
