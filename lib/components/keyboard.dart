import 'package:flutter/material.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) cb;
  const Keyboard(this.cb);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button.history(
                text: 'hist', color: Color.fromRGBO(48, 48, 48, 1), cb: cb),
            Button.big(text: '', color: Color.fromRGBO(48, 48, 48, 1), cb: cb),
            Button.backspace(
                text: '<-', color: Color.fromRGBO(0, 0, 0, 1), cb: cb),
          ]),
          ButtonRow([
            Button(text: 'C', color: Button.DARK, cb: cb),
            Button(text: '( )', color: Button.DARK, cb: cb),
            Button(text: '%', color: Button.DARK, cb: cb),
            Button.operation(text: '/', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          ButtonRow([
            Button(text: '7', cb: cb),
            Button(text: '8', cb: cb),
            Button(text: '9', cb: cb),
            Button.operation(text: 'x', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          ButtonRow([
            Button(text: '4', cb: cb),
            Button(text: '5', cb: cb),
            Button(text: '6', cb: cb),
            Button.operation(text: '-', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          ButtonRow([
            Button(text: '1', cb: cb),
            Button(text: '2', cb: cb),
            Button(text: '3', cb: cb),
            Button.operation(text: '+', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          ButtonRow([
            Button.big(text: '0', cb: cb),
            Button(text: ',', cb: cb),
            Button.operation(text: '=', cb: cb),
          ]),
        ],
      ),
    );
  }
}
