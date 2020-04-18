import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Transferências";

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: ListView.builder(
            itemCount: widget._transferencias.length,
            itemBuilder: (context, indice) =>
                ItemTransferencia(widget._transferencias[indice])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormularioTransferencia())
                  )
            .then( (transferencia) => _atualizaTransferencias(transferencia));
          },
          child: Icon(Icons.add_circle),
        ));
  }

  void _atualizaTransferencias(Transferencia transferencia) {
    if (transferencia != null) {
      setState(() => widget._transferencias.add(transferencia));
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
