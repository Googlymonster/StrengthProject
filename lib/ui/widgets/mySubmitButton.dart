import 'package:flutter/material.dart';
import 'package:strength_project/core/global.dart';

class MySubmitButton extends StatelessWidget {
  final Function _handler;
  final String _actionText;
  MySubmitButton(this._handler, this._actionText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: blueTheme,
        textColor: Colors.white,
        onPressed: this._handler,
        child: Text(_actionText),
      ),
    );
  }
}
