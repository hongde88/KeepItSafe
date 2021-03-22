import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:keep_it_safe/models/item.dart';

class ItemList extends ChangeNotifier {
  List<Item> _list = [];

  List<Item> get list {
    return UnmodifiableListView(_list);
  }

  void addItem(Item item) {
    _list.add(item);
    notifyListeners();
  }
}
