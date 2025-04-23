// import 'package:calculator/data/datasource.dart';
// import 'package:calculator/models/history_model.dart';
import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';

class ListHistory extends StatelessWidget {
  const ListHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: FractionallySizedBox(
        heightFactor: 0.525,
        widthFactor: 0.75,
        child: Material(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texto do histórico
                const Expanded(
                  child: Center(
                    child: Text(
                      'Nenhum histórico disponível',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Ação de limpar o histórico
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Button.GREY,
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Limpar histórico',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
