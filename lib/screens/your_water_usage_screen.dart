import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class YourWaterUsageScreen extends StatefulWidget {
  final String selectedGoal;
  const YourWaterUsageScreen({Key? key, required this.selectedGoal}) : super(key: key);

  @override
  _YourWaterUsageScreenState createState() => _YourWaterUsageScreenState();
}

class _YourWaterUsageScreenState extends State<YourWaterUsageScreen> {
  int _selectedIndex = 0;
  final List<int> waterUsageDays = List.generate(7, (_) => Random().nextInt(10) + 40); // Data for 7 days

  final List<int> waterUsageMonths = List.generate(4, (_) => Random().nextInt(200) + 300); // Data for 4 months
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
  final List<String> months = ['Apr', 'May', 'Jun', 'Jul'];
  // Linear regression model
  double predictNextDayConsumption(List<int> data) {
    double average = calculateAverage(data);
    return average * getMultiplier(); // Use getMultiplier() function to get the correct multiplier.
  }

  double calculateAverage(List<int> data) {
    double total = data.reduce((sum, value) => sum + value).toDouble();
    return total / data.length;
  }

  double getMultiplier() {
    if (widget.selectedGoal == 'Novice') {
      return 0.95;
    } else if (widget.selectedGoal == 'Seasoned') {
      return 0.85;
    } else if (widget.selectedGoal == 'Elite') {
      return 0.75;
    } else {
      return 1.0;
    }
  }

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
                  padding: const EdgeInsets.only(top: 16),
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
                          '${waterUsageDays.reduce((sum, value) => sum + value)} liters',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                        const Text(
                          'Recommended Water Usage for Next Day',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        Text(
                          '${predictNextDayConsumption(waterUsageDays).toStringAsFixed(1)} liters',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: WaterUsageLineChart(
                    waterUsage: waterUsageDays,
                    recommendedLiters: predictNextDayConsumption(waterUsageDays),
                    labels: weekdays,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Average Monthly Water Consumption',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: '${(waterUsageMonths.take(3).reduce((sum, value) => sum + value) / 3).toInt()}',
                              style: const TextStyle(color: Colors.blue), // Set the color to blue
                            ),
                            const TextSpan(
                              text: ' liters',
                              style: TextStyle(color: Colors.blue), // Set the word "liters" in blue color
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                Expanded(
                  child: WaterUsageBarChart(waterUsage: waterUsageMonths, labels: months),
                ),
              ],
            ),
    );
  }
}

class WaterUsageLineChart extends StatelessWidget {
  final List<String> labels;
  final List<int> waterUsage;
  final double recommendedLiters;

  WaterUsageLineChart({required this.labels, required this.waterUsage, required this.recommendedLiters});

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
                if (index >= 0 && index < labels.length) {
                  return labels[index];
                }
                return '';
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              margin: 16, // Adjust the margin for leftTitles
              reservedSize: 40, // Adjust the reservedSize for leftTitles
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
              spots: labels
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), waterUsage[entry.key].toDouble()))
                  .toList(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            // Add the red dotted line representing recommended liters
            LineChartBarData(
              spots: labels
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), recommendedLiters))
                  .toList(),
              isCurved: true,
              colors: [Colors.red],
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              dashArray: [5, 5], // Make the line dotted
            ),
          ],
        ),
      ),
    );
  }
}

class WaterUsageBarChart extends StatelessWidget {
  final List<String> labels;
  final List<int> waterUsage;

  WaterUsageBarChart({required this.labels, required this.waterUsage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              margin: 8,
              getTitles: (double value) {
                int index = value.toInt();
                if (index >= 0 && index < labels.length) {
                  return labels[index];
                }
                return '';
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              margin: 16, // Adjust the margin for leftTitles
              reservedSize: 40, // Adjust the reservedSize for leftTitles
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
          maxY: waterUsage.reduce(max).toDouble() + 50, // Adjust the maxY for more space
          borderData: FlBorderData(show: true),
          barGroups: waterUsage
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(y: entry.value.toDouble(), colors: [Colors.blue]),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: YourWaterUsageScreen(selectedGoal: 'Novice'),
  ));
}
