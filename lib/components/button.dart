import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(224, 93, 174, 1);
  static const OPERATION = Color.fromRGBO(95, 1, 104, 1);

  final String text;
  final bool big;
  final Color color;
  final isBackspace;
  final void Function(String) cb;

  const Button({
    required this.text,
    this.big = false,
    this.color = DEFAULT,
    this.isBackspace = false,
    required this.cb,
  });

  const Button.big({
    required this.text,
    this.big = true,
    this.color = DEFAULT,
    this.isBackspace = false,
    required this.cb,
  });

  const Button.operation({
    required this.text,
    this.big = false,
    this.color = OPERATION,
    this.isBackspace = false,
    required this.cb,
  });

  const Button.backspace({
    required this.text,
    this.big = false,
    this.color = OPERATION,
    this.isBackspace = true,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        onPressed: () => cb(text),
        child: this.isBackspace
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.backspace),
                  SizedBox(width: 8),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
