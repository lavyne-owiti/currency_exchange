import 'dart:developer';

import 'package:currency_exchange_app/feature/currency_trade/data/remote_datasource.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class CurrencySwapScreen extends StatefulWidget {
  const CurrencySwapScreen({super.key});

  @override
  State<CurrencySwapScreen> createState() => _CurrencySwapScreenState();
}

class _CurrencySwapScreenState extends State<CurrencySwapScreen> {
  CurrencyService currencyService = CurrencyService();
  String from = 'USD';
  String to = 'KES';
  double amount = 100;

  double? convertedAmount;
  double? exchangeRate;
  Map<String, double>? chartRates;
  bool isLoading = true;

  Future<void> _fetchCurrencies() async {
    try {
      List<String> result = await currencyService.fetchCurrency();
      setState(() {
        currencyService.currencies = result;
        log('Fetched currencies: ${currencyService.currencies}');
      });
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  Future<void> fetchRate() async {
    try {
      List<String> result = await currencyService.fetchLiveRatesfromUsd();
      setState(() {
        currencyService.liveRates = result;
        log('Exchange rate from ${currencyService.liveRates}');
      });
    } catch (error) {
      print('Error fetching exchange rate: $error');
    }
  }

  Future<void> fetchAllData() async {
    setState(() => isLoading = true);

    try {
      final conv = await currencyService.convertCurrency(
        from: from,
        to: to,
        amount: amount,
      );

      final rate = await currencyService.fetchRate(from, to);

      final now = DateTime.now();
      final startDate =
          now.subtract(const Duration(days: 6)).toIso8601String().split('T')[0];
      final endDate = now.toIso8601String().split('T')[0];

      final timeseries = await currencyService.fetchTimeSeries(
        from: from,
        to: to,
        startDate: startDate,
        endDate: endDate,
      );

      setState(() {
        convertedAmount = conv;
        exchangeRate = rate;
        chartRates = timeseries;
      });
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
    fetchAllData();
    fetchRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('From USD TO Any Currency',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('To',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            // IconButton(
            //     onPressed: () {
            //       print('${currencyService.liveRates}');
            //     },
            //     icon: Icon(Icons.swap_horiz)),
            DropdownButtonFormField<String>(
              value: to,
              decoration: InputDecoration(
                labelText: 'Select Currency',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
              ),
              items: currencyService.currencies
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    to = value;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text('Exchange Rate', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return
                      // TransactionCard(
                      //   fromCurrency: 'USD',
                      //   toCurrency: 'KES',
                      //   inputAmount: 100,
                      //   convertedAmount: 12000,
                      //   exchangeRate: 120.0,
                      //   changePercentage: 2.5,
                      // );
                      TransactionCard(
                    fromCurrency: from,
                    toCurrency: to,
                    inputAmount: amount,
                    convertedAmount: convertedAmount ?? 0,
                    exchangeRate: exchangeRate ?? 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
