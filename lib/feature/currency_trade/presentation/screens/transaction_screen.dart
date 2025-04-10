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
        child: Column(
          children: [
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
    );
  }
}
