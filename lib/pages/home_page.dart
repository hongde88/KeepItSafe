import 'package:flutter/material.dart';
import 'package:keep_it_safe/models/item_tile.dart';
import 'package:keep_it_safe/models/main_screen_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const pageIdx = 2;
  final TextEditingController _searchController = TextEditingController();
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            focusNode: textFieldFocusNode,
            keyboardType: TextInputType.text,
            onTap: () {
              textFieldFocusNode.requestFocus();
            },
            onChanged: (value) {},
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    25.0,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  textFieldFocusNode.unfocus();
                  // textFieldFocusNode.canRequestFocus = false;
                  _searchController.clear();
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Consumer<MainScreenState>(
            builder: (context, state, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemTile(
                    type: 'card',
                    title: 'chase',
                    onTap: () {},
                  );
                },
                itemCount: state.itemList.list.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
