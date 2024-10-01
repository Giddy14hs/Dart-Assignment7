import 'package:flutter/material.dart';
import 'moneyPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SendMoneyPage(),
    );
  }
}
