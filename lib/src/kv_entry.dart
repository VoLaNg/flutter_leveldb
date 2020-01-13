import 'raw_data.dart';
import 'extensions.dart';

class KeyValue<K, V> {
  final K key;
  final V value;
  KeyValue(this.key, this.value) : assert(key != null && value != null);
}

extension DisposableKeyValue on KeyValue<RawData, RawData> {
  bool get isDisposed => key.isDisposed && value.isDisposed;

  void dispose() {
    if (isDisposed) return;
    key.dispose();
    value.dispose();
  }
}
