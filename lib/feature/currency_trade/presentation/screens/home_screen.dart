import 'package:currency_exchange_app/feature/currency_trade/presentation/widgets/transactions_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'My Wallet',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.all(50),
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
              'Qquick Actions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('send'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Recieve'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Swap'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Buy'),
                ),
              ],
            ),
            Text('Transactions', style: TextStyle(fontSize: 20)),
            Expanded(child: TransactionWidget())
          ],
        ),
      ),
    );
  }
}
