import 'package:calculator/components/button.dart';
import 'package:calculator/models/mobx_store/memory_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'screens/calculator.dart';
import 'package:flutter/services.dart';

void main() {
  GetIt.I.registerSingleton<MemoryStore>(MemoryStore());
  SetNavigationBarColor();
  runApp(MyApp());
}

void SetNavigationBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Button.GREY,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
