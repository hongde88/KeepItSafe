import 'package:flutter/material.dart';
import 'package:keep_it_safe/models/item.dart';
import 'package:keep_it_safe/models/item_list.dart';
import 'package:keep_it_safe/pages/home_page.dart';

class MainScreenState extends ChangeNotifier {
  ItemList _itemList = ItemList();
  int _pageIdx = 2;
  Widget _page = HomePage();

  ItemList get itemList {
    return _itemList;
  }

  int get pageIdx {
    return _pageIdx;
  }

  Widget get page {
    return _page;
  }

  void setPage(int pageIdx, Widget page) {
    _pageIdx = pageIdx;
    _page = page;
    notifyListeners();
  }

  void addItem(Item item) {
    _itemList.addItem(item);
  }
}
