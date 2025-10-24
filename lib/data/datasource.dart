import 'dart:io';

import 'package:calculator/data/data_objects.dart';
import 'package:calculator/data/domain/entities/memory_entity.dart';
import 'package:calculator/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DataSource {
  Future<Database> _getDataBase() async {
    // await deleteDatabase(
    //   join(await getDatabasesPath(), database_name),
    // );
    return openDatabase(
      join(await getDatabasesPath(), database_name),
      onCreate: (db, version) async {
        await db.execute(create_table_script);
      },
      version: database_version,
    );
  }

  Future insert(MemoryEntity memory) async {
    try {
      final Database db = await _getDataBase();
      String generated_code = Uuid().v4();
      print(DateTime.now().millisecondsSinceEpoch);

      memory.resultId = await db.rawInsert('''
        INSERT INTO $table_name ($column_code, $column_expression, $column_result, $column_date)
        VALUES ('$generated_code', '${memory.expression}', ${double.parse(memory.result.toStringAsFixed(4))}, ${DateTime.now().millisecondsSinceEpoch})
      ''');

      copyDatabase();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao inserir dado. Erro: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
  }

  Future<void> copyDatabase() async {
    try {
      var status = await Permission.storage.request();

      if (status.isGranted) {
        String databasePath = await getDatabasesPath();
        String destinationDir = "/storage/emulated/0/calculator/data";

        // Cria um objeto File do caminho original
        File sourceFile = File(databasePath + '/' + database_name);

        if (!await sourceFile.exists()) {
          print('O arquivo de origem não existe.');
          return;
        }
        // Cria a pasta de destino se não existir
        if (!await Directory(destinationDir).exists()) {
          await Directory(destinationDir).create(recursive: true);
        }

        // Cria o novo caminho de destino
        String destinationPath = join(destinationDir, database_name + '.db3');

        // Copia o arquivo para a nova pasta
        await sourceFile.copy(destinationPath);

        print('Arquivo copiado com sucesso para: $destinationPath');
      }
    } catch (e) {
      print('Erro ao copiar o arquivo: $e');
    }
  }

  Future<List<HistoryModel>> getAll() async {
    try {
      final Database db = await _getDataBase();
      final yesterday =
          // ignore: prefer_const_constructors
          DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;

      print('Yesterday: $yesterday');

      final List<Map<String, dynamic>> historyMap = await db.query(table_name,
          orderBy: '$column_date DESC', where: '$column_date >= $yesterday');

      return List.generate(historyMap.length, (index) {
        return HistoryModel.fromMap(historyMap[index]);
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao buscar dados. Erro: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return List.empty();
    }
  }
}
