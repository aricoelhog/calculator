import 'package:calculator/data/datasource.dart';
import 'package:calculator/models/history_model.dart';
import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({super.key});

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  final DataSource _dataSource = DataSource();
  List<HistoryModel> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final result = await _dataSource.getAll();
    print('Resulttt: $result');
    setState(() {
      _history = result;
      _isLoading = false;
    });
  }

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
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : _history.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhum histórico disponível',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _history.length,
                              itemBuilder: (context, index) {
                                final item = _history[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    '${item.expression} = ${item.result}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                ),
                OutlinedButton(
                  onPressed: () {},
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
