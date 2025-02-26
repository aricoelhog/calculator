import 'package:calculator/data/datasource.dart';
import 'package:calculator/models/history_model.dart';
import 'package:flutter/material.dart';

class ListHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: FutureBuilder(
          future: DataSource().getAll(),
          builder: (BuildContext context,
              AsyncSnapshot<List<HistoryModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade400,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final HistoryModel history = snapshot.data![index];
                return Padding(
                  padding: EdgeInsets.only(left: 8, right: 4),
                  child: Text(
                    history.expression,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
