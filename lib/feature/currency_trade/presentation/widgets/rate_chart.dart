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
      height: 250,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.white,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: const Text('Date'),
              sideTitles: SideTitles(
                showTitles: true,
                interval: (sortedDates.length / 4)
                    .floorToDouble()
                    .clamp(1, double.infinity),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedDates.length) {
                    final date = sortedDates[index].substring(5); 
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(date,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey)),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: const Text('Rate'),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  value.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300),
          ),
          minX: 0,
          maxX: (spots.length - 1).toDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlueAccent.withOpacity(0.4),
                    Colors.lightBlueAccent.withOpacity(0.05)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black87,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.x.toInt();
                  return LineTooltipItem(
                    '${sortedDates[index]}: ${spot.y.toStringAsFixed(2)}',
                    const TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
