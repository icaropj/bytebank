import 'dart:convert';

import 'package:bytebank/http/logging_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

Future<List<Transaction>> findAll() async {
  final Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get('http://192.168.5.234:8080/transactions')
      .timeout(Duration(seconds: 10));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(transactionJson['value'],
        Contact(0, contactJson['name'], contactJson['accountNumber']));
    transactions.add(transaction);
  }
  return transactions;
}
