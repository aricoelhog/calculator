import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Memory {
  static const equal = const ['='];
  static const operations = const ['%', '/', 'x', '-', '+'];

  String _value = '0';
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  bool _wipeValue = false;

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else if (equal.contains(command)) {
      _equals();
    } else {
      _addDigit(command);
    }
  }

  double calculate(String expression) {
    expression = treatment(expression);

    // if (!_isValidExpression(expression)) {
    //   print('Expressão inválida: $expression');
    //   return 0;
    // }

    try {
      print(expression);
      final parser = Expression.parse(expression);

      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(parser, {});

      return result is num ? result.toDouble() : 0;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao avaliar a expressão: $expression. Erro: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return 0;
    }
  }

  String treatment(String expression) {
    expression = expression.replaceAll(',', '.');
    expression = expression.replaceAll('x', '*');
    expression = _replacePercentage(expression);
    expression = _adjustExpression(expression);
    return expression;
  }

  String _replacePercentage(String expression) {
    return expression.replaceAllMapped(
      RegExp(r'(\d+(\.\d+)?)%'),
      (match) {
        final number = match[1];
        final leftValue = _getLeftValue(expression, match.start);
        return '($leftValue * $number) / 100';
      },
    );
  }

  String _getLeftValue(String expression, int percentPosition) {
    final leftExpression = expression.substring(0, percentPosition).trim();
    final regex = RegExp(r'(\d+(\.\d+)?)');
    final match = regex.firstMatch(leftExpression);
    return match?.group(1) ?? '0';
  }

  String _adjustExpression(String expression) {
    final endsWithComma = RegExp(r'\.$');
    if (endsWithComma.hasMatch(expression)) {
      expression += '0';
    }
    return expression;
  }

  // bool _isValidExpression(String expression) {
  //   final validCharacters = RegExp(
  //       r'^/^[0-9]+([+\-*\/%]([0-9]+|\([0-9]+\s*\*\s*[0-9]+\)\s*\/\s*100))?$');
  //   if (!validCharacters.hasMatch(expression)) return false;

  //   final endsWithOperator = RegExp(r'[+\-*/%]$');
  //   if (endsWithOperator.hasMatch(expression)) return false;

  //   return true;
  // }

  String replaceDotWithComma(String input) {
    return input.replaceAll('.', ',');
  }

  _equals() {
    _buffer[_bufferIndex] = calculate(_value);
    print(replaceDotWithComma(_buffer[_bufferIndex].toString()));
    _value = replaceDotWithComma(_buffer[_bufferIndex].toString());
    _value = _value.endsWith(',0') ? _value.split(',')[0] : _value;
    _wipeValue = true;
  }

  _addDigit(String digit) {
    final isDot = digit == ',';

    if (isDot) {
      if (operations.contains(_value.characters.last)) {
        _value += '0';
      }

      final parts = _value.split(RegExp(r'[+\-x/%]'));

      final lastNumber = parts.isNotEmpty ? parts.last : '';

      if (lastNumber.contains(',')) {
        return;
      }
    }

    final wipeValue = (_value == '0' && !isDot) || _wipeValue;
    final currentValue = wipeValue ? '' : _value;

    print(_value.characters.last);
    if (operations.contains(_value.characters.last) &&
        operations.contains(digit)) {
      print('Operation');
      _value = currentValue.substring(0, currentValue.length - 1) + digit;
    } else {
      _value = currentValue + digit;
    }
    _wipeValue = false;
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _wipeValue = false;
  }

  String get value {
    return _value;
  }
}
