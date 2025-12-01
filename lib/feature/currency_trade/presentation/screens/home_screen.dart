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
 

  
  double amount = 100;


  @override
  void initState() {
    super.initState();
 
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
        
            Text('Currencies', style: TextStyle(fontSize: 20)),
            Expanded(child: CurrencyWidget()),
          ],
        ),
      ),
    );
  }
}
