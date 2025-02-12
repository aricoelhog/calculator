import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Memory {
  static const equal = const ['='];
  static const operations = const ['%', '/', 'x', '-', '+'];

  String _value = '0';
  double _result = 0;
  bool _wipeValue = false;

  void applyCommand(String command) {
    if (command == 'C') {
      _allClear();
    } else if (equal.contains(command)) {
      _equals();
    } else {
      _addDigit(command);
    }
  }

  _equals() {
    // Conta a quantidade de parênteses de abertura '(' e fechamento ')' na expressão
    int openParentheses = _value.split('(').length - 1;
    int closeParentheses = _value.split(')').length - 1;

    // Se houver mais parênteses de abertura do que fechamento, adiciona os que faltam no final
    while (closeParentheses < openParentheses) {
      _value += ')';
      closeParentheses++;
    }

    // Calcula o resultado da expressão e armazena no buffer
    _result = calculate(_value);

    // Converte o resultado para string, substituindo ponto por vírgula
    _value = replaceDotWithComma(_result.toString());

    // Remove ',0' do final da string para evitar valores como "10,0"
    _value = _value.endsWith(',0') ? _value.split(',')[0] : _value;

    // Define a flag para limpar o valor na próxima entrada
    _wipeValue = true;
  }

  String replaceDotWithComma(String input) {
    return input.replaceAll('.', ',');
  }

  double calculate(String expression) {
    try {
      expression = treatment(expression);
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
        return '( $number / 100 )';
      },
    );
  }

  String _adjustExpression(String expression) {
    final endsWithComma = RegExp(r'\.$');
    if (endsWithComma.hasMatch(expression)) {
      expression += '0';
    }
    return expression;
  }

  _addDigit(String digit) {
    try {
      final isDot =
          digit == ','; // Verifica se o dígito inserido é uma vírgula.

      // Se o botão pressionado for vírgula
      if (isDot) {
        // Se o último caractere for uma operação, adiciona um zero antes da vírgula. Exemplo: "6+" → "6+0,"
        if (operations.contains(_value.characters.last)) {
          _value += '0';
        }

        // _value é dividido em partes usando operadores matemáticos (+, -, x, /, %) como delimitadores.
        final parts = _value.split(RegExp(r'[+\-x/%]'));
        // Obtém o último número digitado.
        final lastNumber = parts.isNotEmpty ? parts.last : '';
        // Se o último número já contém uma vírgula, impede a adição de outra.
        if (lastNumber.contains(',')) {
          return;
        }
      }

      // Se _value for '0' e não for um ponto decimal, ou _wipeValue for verdadeiro, a variável wipeValue será verdadeira.
      final wipeValue = (_value == '0' && !isDot) || _wipeValue;
      // Se wipeValue for verdadeiro, currentValue será vazio, caso contrário, será igual a _value.
      final currentValue = wipeValue ? '' : _value;

      if (_wipeValue && operations.contains(digit) && digit != '-') {
        return;
      }
      // Se estiver somente digitado 0, impede que a expressão inicie com um operador
      else if ((_value == '0' && operations.contains(digit) && digit != '-') ||
          (_value == '-' && operations.contains(digit))) {
        _wipeValue = false;
        return;
      }

      // Se o último caractere e o dígito inserido forem operadores, e o último caractere for diferente de %
      // e igual ao dígito inserido, substitui o último operador pelo novo.
      else if (operations.contains(_value.characters.last) &&
          operations.contains(digit) &&
          !(_value.characters.last == '%' && _value.characters.last != digit)) {
        _value = currentValue.substring(0, currentValue.length - 1) + digit;
      }

      // Se o dígito inserido for "( )", controla a adição de parênteses na expressão.
      else if (digit == '( )') {
        // Conta quantos parênteses de abertura '(' e fechamento ')' existem na expressão
        int openParentheses = _value.split('(').length - 1;
        int closeParentheses = _value.split(')').length - 1;

        // Se _value for "0", substitui por "(" ao invés de apenas concatenar
        if (_value == '0') {
          _value = '(';
        }
        // Se o último caractere for um número ou ')', adiciona um parêntese de fechamento ')'
        else if (RegExp(r'\d$').hasMatch(_value) ||
            _value.characters.last == ')') {
          if (openParentheses > closeParentheses) {
            _value = _value + ')';
          }
        }
        // Se o último caractere for um operador ou a string estiver vazia, adiciona um '('
        else {
          _value = _value + '(';
        }
      }

      // Se o dígito inserido for '<-', remove o último caractere.
      else if (digit == '<-') {
        // Se houver apenas um caractere, redefine _value para '0'.
        if (_value.length == 1) {
          _value = '0';
        }
        // Caso contrário, remove o último caractere da string.
        else {
          _value = currentValue.characters.skipLast(1).toString();
        }
      }

      // Para qualquer outro dígito, apenas o adiciona à string.
      else {
        _value = currentValue + digit;
      }

      // Após qualquer alteração, reseta _wipeValue para falso.
      _wipeValue = false;
    } catch (e) {
      // Em caso de erro, exibe uma notificação de erro na tela.
      Fluttertoast.showToast(
        msg: "Ocorreu um erro ao digitar: Erro: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return 0;
    }
  }

  _allClear() {
    _value = '0';
    _result = 0;
    _wipeValue = false;
  }

  String get value {
    return _value;
  }
}
