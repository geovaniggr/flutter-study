import 'package:flutter/material.dart';
import 'package:spbank/screens/dashboard.dart';

import 'component/transaction_auth_dialog.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.greenAccent[300],
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.greenAccent[300],
            textTheme: ButtonTextTheme.primary),
      ),
      home: Dashboard(),
    );
  }
}
