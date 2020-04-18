import 'package:bytebank/components/campo_texto.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Criar Transferência";
const _rotuloNumeroConta = "Número da Conta";
const _rotuloValorConta = "Valor da Transferência";
const _dicaNumeroConta = "0000";
const _dicaValorConta = "0.00";
const _confirm = "Confirmar";

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CampoTexto(
                  controlador: _controllerNumeroConta,
                  rotulo: _rotuloNumeroConta,
                  dica: _dicaNumeroConta),
              CampoTexto(
                  controlador: _controllerCampoValor,
                  rotulo: _rotuloValorConta,
                  dica: _dicaValorConta,
                  icone: Icons.monetization_on),
              RaisedButton(
                child: Text(_confirm, style: TextStyle(fontSize: 16)),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double valor = double.tryParse(_controllerCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transf = Transferencia(valor, numeroConta);
      Navigator.pop(context, transf);
    }
  }
}
