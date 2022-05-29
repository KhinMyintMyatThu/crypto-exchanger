import 'dart:convert';
import 'package:flutter_app/constants/api_constants.dart';
import 'package:flutter_app/data/models/currency_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ApiRepository {
  getCurrencyData() async {
    List<Currency> currencies = [];
    var url = currencyApi;
    Map<String, dynamic> returnValue;

    Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      for (var item in body['markets']) {
        var currency = Currency(
            exchangeID: item['exchange_id'],
            currencySymbol: item['symbol'],
            baseAsset: item['base_asset'],
            quoteAsset: item['quote_asset'],
            exchangePrice: num.parse(item['price'].toStringAsFixed(2)),
            intlCurrencies: item['quote'],
            updatedAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(item['updated_at']),
            marketChangePrice: item['change_24h']);
        currencies.add(currency);
      }
      returnValue = {'currencies': currencies, 'hasError': false};
    } else {
      returnValue = {'currencies': currencies, 'hasError': true};
    }
    return returnValue;
  }
}
