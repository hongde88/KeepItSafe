import 'package:flutter/material.dart';
import 'package:keep_it_safe/components/kis_form_field.dart';
import 'package:keep_it_safe/models/item.dart';
import 'package:keep_it_safe/models/main_screen_state.dart';
import 'package:keep_it_safe/pages/home_page.dart';
import 'package:provider/provider.dart';

class NewPage extends StatefulWidget {
  static const int pageIdx = 1;

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final _formKey = GlobalKey<FormState>();
  final List<KISFormField> _extraFields = [];
  final Item _item = Item();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _extraFields.add(KISFormField(
                      leading: Icon(Icons.extension_sharp),
                      hintText: 'Enter an extra field',
                      validator: (value) {
                        _item.addField(value, value);
                        return null;
                      },
                    ));
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    for (var entry in _item.fields.entries) {
                      print('${entry.key} -> ${entry.value}');
                    }

                    MainScreenState state = Provider.of<MainScreenState>(
                      context,
                      listen: false,
                    );

                    state.addItem(_item);
                    state.setPage(HomePage.pageIdx, HomePage());
                  }
                },
              ),
              // IconButton(icon: Icon(Icons.clear), onPressed: () {}),
            ],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KISFormField(
                    leading: Icon(Icons.category),
                    validator: (value) {
                      // _item.addField('category', value);
                      print('in validator');
                      print(value);
                      return null;
                    },
                    onChanged: (selectedValue) {
                      print('in onchanged');
                      print(selectedValue);
                      return (value) {
                        setState(() {
                          print('in callback in onchange');
                          print(value);
                          selectedValue = value;
                        });
                      };
                      // _item.addField('category', value);
                    },
                    isDropDown: true,
                  ),
                  KISFormField(
                    hintText: 'Enter a user name',
                    leading: Icon(Icons.account_box),
                    validator: (value) {
                      _item.addField('username', value);
                      return null;
                    },
                  ),
                  KISFormField(
                    hintText: 'Enter a password',
                    leading: Icon(Icons.lock),
                    validator: (value) {
                      _item.addField('password', value);
                      return null;
                    },
                  ),
                  KISFormField(
                    hintText: 'Enter a website',
                    leading: Icon(Icons.home),
                    validator: (value) {
                      _item.addField('website', value);
                      return null;
                    },
                  ),
                  ..._getMoreFields(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getMoreFields() {
    List<Widget> fields = [];

    fields.addAll(_extraFields);

    return fields;
  }
}
