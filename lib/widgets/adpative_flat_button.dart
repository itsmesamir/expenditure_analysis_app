import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String txt;
  final Function _datePicker;

  AdaptiveFlatButton(this.txt, this._datePicker);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _datePicker,
            child: Text(txt),
          )
        : FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.deepPurple,
              ),
            ),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: _datePicker,
            child: Text(txt),
          );
  }
}
