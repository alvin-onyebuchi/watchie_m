import 'package:flutter/material.dart';
import 'package:watchie/data/notifiers.dart';
import 'package:watchie/pages/onbording1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isdarkModeNotifier,
      builder: (context, darkMode, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: darkMode ? Brightness.dark : Brightness.light,
          ),
        ),
        home: Onbording(),
      ),
    );
  }
}
