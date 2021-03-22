import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String type;
  final String title;
  final Function onTap;

  ItemTile({this.title, this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: type == 'card' ? Icon(Icons.credit_card) : Icon(Icons.email),
      title: Text(
        title,
      ),
      onTap: onTap,
    );
  }
}
