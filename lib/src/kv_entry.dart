class KeyValue<K, V> {
  final K key;
  final V value;
  KeyValue(this.key, this.value) : assert(key != null && value != null);
}
