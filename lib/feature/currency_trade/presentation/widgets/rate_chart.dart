import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RateChart extends StatelessWidget {
  final Map<String, double> rates; 

  const RateChart({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    final sortedDates = rates.keys.toList()..sort();
    final spots = <FlSpot>[];

    for (int i = 0; i < sortedDates.length; i++) {
      spots.add(FlSpot(i.toDouble(), rates[sortedDates[i]]!));
    }

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (sortedDates.length / 4).floorToDouble(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedDates.length) {
                    final date = sortedDates[index].substring(5); // MM-DD
                    return Text(date, style: const TextStyle(fontSize: 10));
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  value.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 2,
              color: Colors.blueAccent,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
