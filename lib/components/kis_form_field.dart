import 'package:flutter/material.dart';
import 'package:keep_it_safe/constants.dart' as Constants;

class KISFormField extends StatefulWidget {
  final Widget leading;
  final String hintText;
  final Function validator;
  final Function onChanged;
  final bool displayTitle;
  final bool isDropDown;

  KISFormField({
    this.leading,
    this.hintText,
    this.validator,
    this.onChanged,
    this.displayTitle = true,
    this.isDropDown = false,
  });

  @override
  _KISFormFieldState createState() => _KISFormFieldState();
}

class _KISFormFieldState extends State<KISFormField> {
  TextEditingController _textController;
  String _selectedValue;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDropDown
        ? _getDropdownButtonFormField()
        : _getTextFormField();
  }

  TextFormField _getTextFormField() {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      controller: _textController,
      // decoration: Constants.kMessageTextFieldDecoration.copyWith(
      //   contentPadding: EdgeInsets.all(15.0),
      //   hintText: widget.hintText,
      //   suffixIcon: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () {
      //       _textController.clear();
      //     },
      //   ),
      // ),
      decoration: Constants.kMessageTextFieldDecoration.copyWith(
        contentPadding: EdgeInsets.only(bottom: 8.0),
        hintText: widget.hintText,
        prefixIcon: widget.leading,
        suffix: IconButton(
          padding: EdgeInsets.only(top: 2.0),
          icon: Icon(Icons.clear),
          onPressed: () {
            _textController.clear();
          },
        ),
      ),
      onChanged: (value) {},
      validator: widget.validator,
    );
  }

  DropdownButtonFormField _getDropdownButtonFormField() {
    return DropdownButtonFormField(
      decoration: Constants.kMessageTextFieldDecoration.copyWith(
        hintText: '',
        contentPadding: EdgeInsets.only(top: 15.0),
        prefixIcon: widget.leading,
      ),
      items: [
        DropdownMenuItem(child: Text('Credit/debit card')),
        DropdownMenuItem(child: Text('Email')),
        DropdownMenuItem(child: Text('Secrets')),
      ],
      onChanged: widget.onChanged(_selectedValue),
      validator: widget.validator,
      value: _selectedValue,
    );
  }
}
