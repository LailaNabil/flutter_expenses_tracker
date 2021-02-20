import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _textInput;
  final Function _functionInput;
  final BuildContext _contextInput;
  final bool _backgroundColor;

  AdaptiveFlatButton(this._textInput,this._functionInput, this._contextInput,this._backgroundColor);

  @override
  Widget build(BuildContext context) {
    if(_backgroundColor) {
      return Platform.isIOS ? CupertinoButton(
        child: Text(_textInput),
        onPressed: _functionInput,
        color: Theme
            .of(_contextInput)
            .primaryColor,

      ) : FlatButton(
        child: Text(_textInput),
        onPressed: _functionInput,
        color: Theme
            .of(_contextInput)
            .primaryColor,
        textColor: Theme
            .of(_contextInput)
            .textTheme
            .button
            .color,
      );
    }
    else{
      return Platform.isIOS ? CupertinoButton(
        child: Text(_textInput),
        onPressed: _functionInput,
      ) : FlatButton(
        child: Text(_textInput),
        onPressed: _functionInput,
      );

    }
  }
}
