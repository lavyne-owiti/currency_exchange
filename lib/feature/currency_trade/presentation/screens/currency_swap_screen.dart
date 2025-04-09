import 'package:flutter/material.dart';

class CurrencySwapScreen extends StatefulWidget {
  const CurrencySwapScreen({super.key});

  @override
  State<CurrencySwapScreen> createState() => _CurrencySwapScreenState();
}

class _CurrencySwapScreenState extends State<CurrencySwapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
