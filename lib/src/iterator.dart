import 'native_wrapper.dart';
import 'raw_data.dart';

// TODO: should conform to Iterator
/// An iterator yields a sequence of key/value pairs from a source.
/// The following class defines the interface.  Multiple implementations
/// are provided by this library.  In particular, iterators are provided
/// to access the contents of a Table or a DB.
abstract class DBIterator extends AnyStructure {
  /// An iterator is either positioned at a key/value pair, or
  /// not valid. This method returns true iff the iterator is valid.
  bool get isValid;

  /// Position at the first key in the source. The iterator [isValid]
  /// after this call iff the source is not empty.
  void seekToFirst();

  /// Position at the last key in the source. The iterator [isValid]
  /// after this call iff the source is not empty.
  void seekToLast();

  /// Position at the first key in the source that is at or past target.
  /// The iterator [isValid] after this call iff the source contains
  /// an entry that comes at or past target.
  void seek(RawData targetKey);

  void next();
  void prev();
  RawData key();
  RawData value();

  String getError();
}
