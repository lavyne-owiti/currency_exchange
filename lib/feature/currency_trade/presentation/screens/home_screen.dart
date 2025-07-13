import 'dart:developer';

import 'package:currency_exchange_app/feature/currency_trade/data/remote_datasource.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/currency_widget.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/rate_chart.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/transaction_card.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/transactions_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> currencies = [];
  CurrencyService currencyService = CurrencyService();
  final CurrencyService service = CurrencyService();

  String from = 'USD';
  String to = 'KES';
  double amount = 100;

  double? convertedAmount;
  double? exchangeRate;
  Map<String, double>? chartRates;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    setState(() => isLoading = true);

    try {
      final conv = await service.convertCurrency(
        from: from,
        to: to,
        amount: amount,
      );

      final rate = await service.fetchRate(from, to);

      final now = DateTime.now();
      final startDate =
          now.subtract(const Duration(days: 6)).toIso8601String().split('T')[0];
      final endDate = now.toIso8601String().split('T')[0];

      final timeseries = await service.fetchTimeSeries(
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'My Wallet',
              style: TextStyle(fontSize: 20),
            ),
            // GestureDetector(
            //   onTap: () {
            //     // _fetchCurrencies();
            //     // log('this currencies $currencies');
            //   },
            //   child: Icon(Icons.abc, size: 30, color: Colors.black54),
            // ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: RichText(
                      text: TextSpan(
                    text: 'KSH',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' 1000',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('send'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Recieve'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Swap'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Buy'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Transactions', style: TextStyle(fontSize: 20)),
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

            Text('Currencies', style: TextStyle(fontSize: 20)),
            Expanded(child: CurrencyWidget()),
          ],
        ),
      ),
    );
  }
}
