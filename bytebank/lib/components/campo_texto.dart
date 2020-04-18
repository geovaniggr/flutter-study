import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  CampoTexto({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
      ),
    );
  }
}
