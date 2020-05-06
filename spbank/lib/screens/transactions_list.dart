import 'package:flutter/material.dart';
import 'package:spbank/component/centered_message.dart';
import 'package:spbank/component/loading.dart';
import 'package:spbank/models/transaction.dart';
import 'package:spbank/webapi/webclients/transaction_webclient.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading(message:"Carregando Transações");
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
            if(!snapshot.hasData) return CenteredMessage("Ocorreu um erro Interno", icon: Icons.error_outline);
              final List<Transaction> transactions = snapshot.data;
              if(transactions.isEmpty) return CenteredMessage("Não há transaçãoes", icon: Icons.error,);
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Transaction transaction = transactions[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
              break;
          }
          return CenteredMessage("Unknow Errror");
        },
      ),
    );
  }
}
