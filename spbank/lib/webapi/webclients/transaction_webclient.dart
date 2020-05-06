import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:spbank/models/transaction.dart';
import 'package:spbank/webapi/interceptors/logging_interceptor.dart';
import 'package:spbank/webapi/webclient.dart';

class TransactionWebClient {

    static final Map<int, String> _statusCodeResponses = {
      400: "Ocorreu um erro para submeter a transação",
      401: "Ocorreu uma falha na autenticação",
      409: "Transferência já foi adicionada"
    };

  Future<List<Transaction>> findAll() async {
    final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<Transaction> transactions = _toTransactions(response);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': password},
        body: transactionJson);

    if(response.statusCode == 200)
          return Transaction.fromJson(jsonDecode(response.body));

    throw HttpException(_getMessage(response.statusCode)); 
  }

  String _getMessage(int statusCode){
    if(_statusCodeResponses.containsKey(statusCode))
      return _statusCodeResponses[statusCode];
    
    return "Ocorreu um erro inesperado";
  }

  List<Transaction> _toTransactions(Response response ) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson.map( (json) => Transaction.fromJson(json)).toList();
  }
}


class HttpException implements Exception {

  final String message;

  HttpException(this.message);

}