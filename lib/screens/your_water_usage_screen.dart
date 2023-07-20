import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class YourWaterUsageScreen extends StatefulWidget {
  const YourWaterUsageScreen({Key? key}) : super(key: key);

  @override
  _YourWaterUsageScreenState createState() => _YourWaterUsageScreenState();
}

class _YourWaterUsageScreenState extends State<YourWaterUsageScreen> {
  int _selectedIndex = 0;
  final List<int> waterUsage = List.generate(7, (_) => Random().nextInt(21) + 30);

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Water Usage Screen'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _onNavItemTapped(0);
                  },
                  child: Container(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Days',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _onNavItemTapped(1);
                  },
                  child: Container(
                    color: _selectedIndex == 1 ? Colors.blue : Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Months',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16), // Add some top padding here
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total Water Consumed for the Week',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${waterUsage.reduce((sum, value) => sum + value)} liters',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: WaterUsageChart(waterUsage: waterUsage),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('This is the months screen.'),
                  ),
                ),
              ],
            ),
    );
  }
}

class WaterUsageChart extends StatelessWidget {
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
  final List<int> waterUsage;

  WaterUsageChart({required this.waterUsage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              margin: 8,
              reservedSize: 22,
              getTitles: (value) {
                int index = value.toInt();
                if (index >= 0 && index < weekdays.length) {
                  return weekdays[index];
                }
                return '';
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              margin: 8,
              reservedSize: 28,
              getTitles: (value) {
                return value.toInt().toString();
              },
            ),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitles: (value) {
                return ''; // Remove the word "liters" from y-axis labels
              },
            ),
          ),
          minY: 0, // Start y-axis from 0
          maxY: waterUsage.reduce(max).toDouble() + 10, // Set max value for y-axis
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: weekdays
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), waterUsage[entry.key].toDouble()))
                  .toList(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

