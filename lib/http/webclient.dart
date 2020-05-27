import 'dart:convert';

import 'package:bytebank/http/logging_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
const String BASE_URL = 'http://192.168.5.234:8080/transactions';

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(BASE_URL).timeout(Duration(seconds: 10));
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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);
  final Response response = await client.post(BASE_URL,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(json['value'],
      Contact(0, contactJson['name'], contactJson['accountNumber']));
}
