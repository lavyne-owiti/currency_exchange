import 'dart:developer';

import 'package:dio/dio.dart';

class CurrencyService {
  final Dio dio = Dio();
   String _baseUrl = 'https://api.exchangerate.host';
   String _accessKey = '96bb8f45e9f348614ea12698dd91d1ac';


  Future<List<String>> fetchCurrencies() async {
    final response = await dio.get('https://api.exchangerate.host/live',
        queryParameters: {"access_key": "96bb8f45e9f348614ea12698dd91d1ac"});
    if (response.statusCode == 200) {
      final data = response.data;
      log('this is the data $data');
      final rates = data['rates'] as Map<String, dynamic>;
      return rates.keys.toList(); // or map to include name/description if needed
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  Future<Map<String, String>> fetchCurrencySymbols() async {
    final response = await dio.get(
      '$_baseUrl/symbols',
      queryParameters: {
        'access_key': _accessKey,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final symbols = data['symbols'] as Map<String, dynamic>;
      return symbols.map((key, value) => MapEntry(key, value['description']));
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  Future<Map<String, double>> fetchLiveRates(String baseCurrency) async {
    final response = await dio.get(
      '$_baseUrl/live',
      queryParameters: {
        'access_key': _accessKey,
        'base': baseCurrency,
      },
    );
    if (response.statusCode == 200) {
      final rates = response.data['rates'] as Map<String, dynamic>;
      return rates
          .map((key, value) => MapEntry(key, (value as num).toDouble()));
    } else {
      throw Exception('Failed to fetch live rates');
    }
  }
Future<double> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    final response = await dio.get(
      '$_baseUrl/convert',
      queryParameters: {
        'access_key': _accessKey,
        'from': from,
        'to': to,
        'amount': amount,
      },
    );
    if (response.statusCode == 200) {
      return (response.data['result'] as num).toDouble();
    } else {
      throw Exception('Currency conversion failed');
    }
  }
  Future<Map<String, dynamic>> fetchHistoricalRates(
      String baseCurrency, String date) async {
    final response = await dio.get(
      '$_baseUrl/$date',
      queryParameters: {
        'access_key': _accessKey,
        'base': baseCurrency,
      },
    );
    if (response.statusCode == 200) {
      return response.data['rates'] as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch historical rates');
    }
  }

}
