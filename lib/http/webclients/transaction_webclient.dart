import 'dart:_http';
import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(buildUri('transactions'));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client.post(
      buildUri('transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode] as String);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction.',
    401: 'Authentication Failed.'
  };
}
