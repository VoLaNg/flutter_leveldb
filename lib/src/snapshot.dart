import 'native_wrapper.dart';

/// Abstract handle to particular state of a DB.
/// A Snapshot is an immutable object and can therefore be safely
/// accessed from multiple threads without any external synchronization.
abstract class Snapshot extends NativeWrapper {}
