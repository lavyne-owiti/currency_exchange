import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final double inputAmount;
  final double convertedAmount;
  final double exchangeRate;
  final double? changePercentage;

  const TransactionCard({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.inputAmount,
    required this.convertedAmount,
    required this.exchangeRate,
    this.changePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = (changePercentage ?? 0) >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$inputAmount $fromCurrency → ${convertedAmount.toStringAsFixed(2)} $toCurrency',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Exchange Rate: 1 $fromCurrency = ${exchangeRate.toStringAsFixed(4)} $toCurrency',
              style: const TextStyle(fontSize: 16),
            ),
            if (changePercentage != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: changeColor,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${isPositive ? '+' : ''}${changePercentage!.toStringAsFixed(2)}% since last update',
                    style: TextStyle(fontSize: 14, color: changeColor),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
