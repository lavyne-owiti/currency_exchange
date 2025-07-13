import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/rate_chart.dart';
import 'package:flutter/material.dart';

class TransaferScreen extends StatefulWidget {
  const TransaferScreen({super.key});

  @override
  State<TransaferScreen> createState() => _TransaferScreenState();
}

class _TransaferScreenState extends State<TransaferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('The Rate Chart', style: TextStyle(fontSize: 15)),
              SizedBox(height: 20),
              //  Expanded(
              //     child:
              RateChart(
                rates: {
                  '2025-07-01': 120.0,
                  '2025-07-02': 121.5,
                  '2025-07-03': 119.0,
                  '2025-07-04': 122.0,
                  '2025-07-05': 123.5,
                },
                // )
              ),
              SizedBox(height: 20),
              Text('Enter Amount to Transfer', style: TextStyle(fontSize: 15)),
              SizedBox(height: 10),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
