import 'dart:developer';

import 'package:dio/dio.dart';

class CurrencyService {
  final Dio dio = Dio();

  Future<List<String>> fetchCurrencies() async {
    final response = await dio.get('https://api.exchangerate.host/symbols',
        queryParameters: {"access_key": "96bb8f45e9f348614ea12698dd91d1ac"});
    if (response.statusCode == 200) {
      final data = response.data;
      log('this is the data $data');
      final symbols = data['symbols'] as Map<String, dynamic>;
      return symbols.keys
          .toList(); // or map to include name/description if needed
    } else {
      throw Exception('Failed to load currencies');
    }
  }
}
