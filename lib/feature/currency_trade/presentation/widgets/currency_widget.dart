import 'dart:developer';

import 'package:currency_exchange_app/feature/currency_trade/data/remote_datasource.dart';
import 'package:flutter/material.dart';

class CurrencyWidget extends StatefulWidget {
  const CurrencyWidget({super.key});

  @override
  State<CurrencyWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<CurrencyWidget> {
  List<String> currencies = [];
  CurrencyService currencyService = CurrencyService();

  Future<void> _fetchCurrencies() async {
    try {
      List<String> result = await currencyService.fetchCurrencies();
      setState(() {
        currencies = result;
        log('Fetched currencies: $currencies');
      });
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey.shade300),
          //   borderRadius: BorderRadius.circular(12.0),
          //   color: Colors.white,
          // ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: currencies.length > 10 ? 10 : currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final currency = currencies[index];
              final parts = currency.split(':');
              final currencyCode = parts[0].trim();
              final rate = parts.length > 1 ? parts[1].trim() : '';
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currencyCode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        rate,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  if (index != currencies.length - 1) // no divider after last
                    const Divider(
                      thickness: 1,
                      height: 16,
                      color: Colors.grey,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
