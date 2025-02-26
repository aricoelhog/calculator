import 'package:calculator/models/mobx_store/memory_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'screens/calculator.dart';

void main() {
  GetIt.I.registerSingleton<MemoryStore>(MemoryStore());
  runApp(Calculator());
}
