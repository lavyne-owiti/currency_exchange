import 'dart:developer';
import 'package:dio/dio.dart';

class CurrencyService {
  final Dio dio = Dio();
  final String _baseUrl = 'https://api.exchangerate.host';
  final String _accessKey = '96bb8f45e9f348614ea12698dd91d1ac';

  Future<List<String>> fetchLiveRatesfromUsd() async {
    final response = await dio
        .get('$_baseUrl/live', queryParameters: {"access_key": _accessKey});
    if (response.statusCode == 200) {
      final data = response.data;
      final quotes = data['quotes'];
      if (quotes != null && quotes is Map<String, dynamic>) {
        return quotes.entries.map((entry) {
          return '${entry.key}: ${entry.value}';
        }).toList();
      } else {
        throw Exception('Unexpected response format: "quotes" is missing');
      }
    } else {
      throw Exception('Failed to load currencies : ${response.statusCode}');
    }
  }

  Future<List<String>> fetchCurrency() async {
    final response = await dio
        .get('$_baseUrl/list', queryParameters: {"access_key": _accessKey});
    if (response.statusCode == 200) {
      final data = response.data;
      final currencies = data['currencies'];
      if (currencies != null && currencies is Map<String, dynamic>) {
        return currencies.keys.toList();
      } else {
        throw Exception('Unexpected response format: "currencies" is missing');
      }
    } else {
      throw Exception('Failed to load currencies : ${response.statusCode}');
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
    // "amount":1
    if (response.statusCode == 200) {
      return (response.data['result'] as num).toDouble();
    } else {
      throw Exception('Currency conversion failed');
    }
  }

  Future<double> fetchRate(String from, String to) async {
    final result = await convertCurrency(from: from, to: to, amount: 1);
    return result;
  }

  Future<Map<String, double>> fetchTimeSeries({
    required String from,
    required String to,
    required String startDate,
    required String endDate,
  }) async {
    final response = await dio.get(
      '$_baseUrl/timeseries',
      queryParameters: {
        'access_key': _accessKey,
        'base': from,
        'symbols': to,
        'start_date': startDate,
        'end_date': endDate,
      },
    );

    if (response.statusCode == 200) {
      final rawRates = response.data['rates'] as Map<String, dynamic>;
      return rawRates
          .map((date, map) => MapEntry(date, (map[to] as num).toDouble()));
    } else {
      throw Exception('Failed to fetch timeseries rates');
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

  Future<Map<String, dynamic>> fetchChangeData(String from, String to) async {
    final response = await dio.get(
      '$_baseUrl/change',
      queryParameters: {
        'access_key': _accessKey,
        'start_date': '2024-01-01',
        'end_date': '2024-07-01',
        'base': from,
        'symbols': to,
      },
    );

    if (response.statusCode == 200) {
      return response.data['change'][to];
    } else {
      throw Exception('Failed to fetch change data');
    }
  }
}

// Future<Map<String, String>> fetchCurrencySymbols() async {
//   final response = await dio.get(
//     '$_baseUrl/symbols',
//     queryParameters: {
//       'access_key': _accessKey,
//     },
//   );
//   if (response.statusCode == 200) {
//     final data = response.data;
//     final symbols = data['symbols'] as Map<String, dynamic>;
//     return symbols.map((key, value) => MapEntry(key, value['description']));
//   } else {
//     throw Exception('Failed to load currencies');
//   }
// }
