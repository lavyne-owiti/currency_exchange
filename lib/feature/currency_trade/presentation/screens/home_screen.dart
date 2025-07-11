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

  Future<void> _fetchCurrencies() async {
    try {
      List<String> result = await currencyService.fetchCurrencies();
      setState(() {
        currencies = result;
      });
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  @override
  void initState() {
    _fetchCurrencies();
    print('this currencies $currencies');
    //  currencyService.fetchCurrencies.then((value) {
    //     setState(() {
    //       currencies = value;
    //     });
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'My Wallet',
              style: TextStyle(fontSize: 20),
            ),
            GestureDetector(
              onTap: () {
                // _fetchCurrencies();
                // log('this currencies $currencies');
              },
              child: Icon(Icons.abc, size: 30, color: Colors.black54),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
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
            SizedBox(height: 20),
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
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
                child: TransactionCard(
              fromCurrency: 'USD',
              toCurrency: 'KES',
              inputAmount: 100,
              convertedAmount: 12000,
              exchangeRate: 120.0,
              changePercentage: 2.5,
            )),

            Text('Currencies', style: TextStyle(fontSize: 20)),
            // Expanded(child: CurrencyWidget()),
            // Expanded(
            //     child: RateChart(
            //   rates: {
            //     '2023-01-01': 120.0,
            //     '2023-01-02': 121.5,
            //     '2023-01-03': 119.0,
            //     '2023-01-04': 122.0,
            //     '2023-01-05': 123.5,
            //   },
            // )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
