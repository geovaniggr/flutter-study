import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  final String message;

  Loading({this.message = "Carregando"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child:
                Text(message, style: TextStyle(fontSize: 18.0)),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
