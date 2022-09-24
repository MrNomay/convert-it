// ignore_for_file: avoid_print

import 'package:convertit/models/RatesModel.dart';
import 'package:convertit/models/currencies.dart';
import 'package:http/http.dart' as http;

Future<Rates> fetchrates() async {
  var url = Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id=87008fdae03148a68d4b867e56f40a04');
  var response = await http.get(url);
  final result = ratesFromJson(response.body);
  return result;
}

Future<Map> fetchcurrency() async {
  var url = Uri.parse('https://openexchangerates.org/api/currencies.json?app_id=87008fdae03148a68d4b867e56f40a04');
  var response = await http.get(url);
  final currlist = currenciesFromJson(response.body);
  return currlist;
}

String conversion(Map exchangeRate, String amount, String baseCurrency,
    String finalCurrency) {
  String output = (double.parse(amount) /
          exchangeRate[baseCurrency] *
          exchangeRate[finalCurrency])
      .toStringAsFixed(2)
      .toString();
  return output;
}
