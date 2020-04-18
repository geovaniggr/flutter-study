import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() => runApp(Bytebank());

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.redAccent[100],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.red[900],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: ListaTransferencias());
  }
}
