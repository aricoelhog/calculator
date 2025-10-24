import 'package:calculator/components/list_history.dart';
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
    setState(() {
      memory.applyCommand(command);
    });
  }

  Future openHistory() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const ListHistory(),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }
}
