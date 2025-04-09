import 'package:flutter/material.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(4.0),
            itemCount: 14,
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
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text('Wallet'),
                  subtitle: const Text('USD'),
                  trailing: RichText(
                      text: TextSpan(
                          text: '0.2%\n',
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                          text: '1000.00',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                      ])),
                  onTap: () {
                    // Handle wallet tap
                  },
                ),
              );
            },
          )),
    );
  }
}
