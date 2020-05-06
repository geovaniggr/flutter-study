import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spbank/component/loading.dart';
import 'package:spbank/component/response_dialog.dart';
import 'package:spbank/component/transaction_auth_dialog.dart';
import 'package:spbank/models/contact.dart';
import 'package:spbank/models/transaction.dart';
import 'package:spbank/webapi/webclients/transaction_webclient.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Loading(
                  message: "Enviando Transação",
                ),
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) => TransactionAuthDialog(
                                onConfirm: (String password) {
                                  _save(transactionCreated, password, context);
                                },
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });

    final Transaction transaction =
        await _send(transactionCreated, password, context);

    showDialog(
        context: context,
        builder: (contextDialog) =>
            SuccessDialog("Transação realizada com sucesso"));

    Navigator.pop(context);
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction = await _webClient
        .save(transactionCreated, password)
        .catchError((timeout) {
      showDialog(
          context: (context),
          builder: (contextDialog) => FailureDialog(
                "Ocorreu um erro Inesperado",
                icon: Icons.error,
              ));
    }, test: (timeout) => timeout is TimeoutException).catchError((err) {
      showDialog(
          context: (context),
          builder: (contextDialog) => FailureDialog(
                err.message,
                title: "Ocorreu um erro",
                icon: Icons.error,
              ));
    }, test: (err) => err is HttpException).catchError((unknowError) {
      showDialog(
          context: (context),
          builder: (contextDialog) => ResponseDialog(title: "Erro Inesperado"));
    }, test: (err) => err is Error).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    return transaction;
  }
}
