import 'package:flutter/material.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Six Hit Challenge')),
        body: Center(child: Text('Six Hit Ready 🏏', style: TextStyle(fontSize: 24))),
      ),
    );
  }
}
