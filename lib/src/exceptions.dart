abstract class LevelDBException implements Exception {
  // factory LevelDBException([var message]) => Exception(message);
  factory LevelDBException([var message]) => Exception(message);
  factory LevelDBException.errptr(String errptr) => ErrptrException(errptr);
  factory LevelDBException.combined(Exception e1, Exception e2) {
    if (e1 is CombinedExceptions) {
      return e1..append(e2);
    } else if (e2 is CombinedExceptions) {
      return e2..append(e1);
    } else {
      return CombinedExceptions([e1, e2]);
    }
  }
}

class ErrptrException implements LevelDBException {
  final String errptr;
  ErrptrException(this.errptr);
}

class CombinedExceptions implements LevelDBException {
  final List<Exception> exceptions;

  CombinedExceptions(this.exceptions);

  void append(Exception e) {
    if (e is CombinedExceptions) {
      exceptions.addAll(e.exceptions);
    } else {
      exceptions.add(e);
    }
  }
}
