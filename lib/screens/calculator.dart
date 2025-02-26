import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/display.dart';
import '../components/keyboard.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    if (command == 'hist') {
      openHistory();
      return;
    }
    setState(() {
      memory.applyCommand(command);
    });
  }

  Future openHistory() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Testeee'),
        ),
      );

  // const Calculator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      home: Column(
        children: <Widget>[
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }
}
