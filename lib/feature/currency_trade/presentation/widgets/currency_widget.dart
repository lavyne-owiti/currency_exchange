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
      });
       log('Fetched currencies: $currencies');
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  @override
  void initState() {
    _fetchCurrencies();
    log('this currencies $currencies');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(4.0),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  child: ListTile(
                    title: Text('Currency'),
                    subtitle: Text('Type'),
                    trailing: RichText(
                        text: TextSpan(
                      text: 'KSH',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 1000',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                  ));
            },
          )),
    );
  }
}
