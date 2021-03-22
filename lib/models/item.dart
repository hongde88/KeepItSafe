import 'dart:collection';

class Item {
  final LinkedHashMap<String, String> _fields = LinkedHashMap<String, String>();

  Map<String, String> get fields {
    return UnmodifiableMapView(_fields);
  }

  void addField(String key, String value) {
    _fields.putIfAbsent(key, () => value);
  }
}
