import 'package:flutter/foundation.dart';
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

  final List<int> waterUsageMonths = List.generate(4, (index) => Random().nextInt(1000) + 1500)
    ..sort((a, b) => b.compareTo(a)); // Generate random numbers and sort them in descending order
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
  final List<String> months = ['Apr', 'May', 'Jun', 'Jul'];

  // Linear regression model
  double predictNextDayConsumption(List<int> data) {
    double average = calculateAverage(data);
    double result = average * getMultiplier();
    return double.parse(result.toStringAsFixed(1)); // Display result with one decimal points
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

  // Calculate the amount of water saved in the middle two months
  int calculateWaterSavedLastMonth(List<int> data) {
    if (data.length < 4) return 0;
    int firstMonthUsage = data[1]; // Second month usage
    int secondMonthUsage = data[2]; // Third month usage
    return firstMonthUsage - secondMonthUsage;
  }

  // New method to calculate the amount of money saved in the middle two months
  double calculateMoneySavedLastMonth(int waterSaved) {
    return (waterSaved / 1000) * 3.70;
  }

  // Calculate the "Lifetime Water Savings" based on the data displayed under "Months" button
  int calculateLifetimeWaterSavings(double averageMonthlyConsumption) {
    return (averageMonthlyConsumption * 12).toInt(); // Assuming 12 months in a year for simplicity
  }

  // New method to calculate the "Lifetime Money Savings" based on the data displayed under "Months" button
  double calculateLifetimeMoneySavings(double lifetimeWaterSavings) {
    double savings = (lifetimeWaterSavings / 1000) * 3.70;
    return double.parse(savings.toStringAsFixed(2)); // Format to 2 decimal points
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
      backgroundColor: Colors.black, // Set a background color for the app bar
      title: const Text(
        'Your Water Usage',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _onNavItemTapped(0);
                  },
                  child: Opacity(
                    opacity: _selectedIndex == 0 ? 1.0 : 0.5, // Set the opacity here
                    child: Container(
                      color: _selectedIndex == 0 ? Colors.grey : Colors.transparent,
                      child: const Center(
                        child: Text(
                          'Weeks',
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
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _onNavItemTapped(1);
                  },
                  child: Opacity(
                    opacity: _selectedIndex == 1 ? 1.0 : 0.5, // Set the opacity here
                    child: Container(
                      color: _selectedIndex == 1 ? Colors.grey : Colors.transparent,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  Text(
                    '${predictNextDayConsumption(waterUsageDays).toStringAsFixed(1)} liters',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 16), // Add some spacing
                  // New Widget to display the "Lifetime Water Savings"
                        Text(
                          'Lifetime Water Savings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '${calculateLifetimeWaterSavings((waterUsageMonths.take(3).reduce((sum, value) => sum + value) / 3).toDouble())}',
                                style: const TextStyle(color: Colors.purple), // Set the color to purple
                              ),
                              const TextSpan(
                                text: ' liters',
                                style: TextStyle(color: Colors.purple), // Set the word "liters" in purple color
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                        // New Widget to display the "Lifetime Money Savings"
                        Text(
                          'Lifetime Money Savings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '\$${calculateLifetimeMoneySavings(calculateLifetimeWaterSavings(waterUsageMonths.take(3).reduce((sum, value) => sum + value) / 3).toDouble())}',                                style: const TextStyle(color: Colors.green), // Set the color to green
                              ),
                            ],
                          ),
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
                        const SizedBox(height: 16), // Add some spacing
                        const Text(
                          'Amount of Water Saved Last Month',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '${calculateWaterSavedLastMonth(waterUsageMonths)}',
                                style: const TextStyle(color: Colors.green), // Set the color to green
                              ),
                              const TextSpan(
                                text: ' liters',
                                style: TextStyle(color: Colors.green), // Set the word "liters" in green color
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                                                // Display the Amount of Money Saved Last Month
                        const Text(
                          'Amount of Money Saved Last Month',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '\$${calculateMoneySavedLastMonth(calculateWaterSavedLastMonth(waterUsageMonths)).toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                        // New Widget to display the "Lifetime Water Savings" for Months
                        Text(
                          'Lifetime Water Savings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '${calculateLifetimeWaterSavings((waterUsageMonths.take(3).reduce((sum, value) => sum + value) / 3).toDouble())}',
                                style: const TextStyle(color: Colors.purple), // Set the color to purple
                              ),
                              const TextSpan(
                                text: ' liters',
                                style: TextStyle(color: Colors.purple), // Set the word "liters" in purple color
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                        // New Widget to display the "Lifetime Money Savings" for Months
                        Text(
                          'Lifetime Money Savings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '\$${calculateLifetimeMoneySavings(calculateLifetimeWaterSavings(waterUsageMonths.take(3).reduce((sum, value) => sum + value) / 3).toDouble())}',                                style: const TextStyle(color: Colors.green), // Set the color to green
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: WaterUsageBarChartAnimated(waterUsage: waterUsageMonths, labels: months),
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

class WaterUsageBarChartAnimated extends StatefulWidget {
  final List<String> labels;
  final List<int> waterUsage;

  WaterUsageBarChartAnimated({required this.labels, required this.waterUsage});

  @override
  _WaterUsageBarChartAnimatedState createState() => _WaterUsageBarChartAnimatedState();
}

class _WaterUsageBarChartAnimatedState extends State<WaterUsageBarChartAnimated> {
  List<double> animatedValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize the animated values to all 0.0 (starting position of the bars)
    animatedValues = List<double>.filled(widget.waterUsage.length, 0.0);
    _animateBars();
  }

  void _animateBars() {
    // Animate the bars to rise from 0 to their respective amount of water consumed that month
    for (int i = 0; i < widget.waterUsage.length; i++) {
      final double targetValue = widget.waterUsage[i].toDouble();
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          animatedValues[i] = targetValue;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, double value, child) {
          return BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  margin: 8,
                  getTitles: (double value) {
                    int index = value.toInt();
                    if (index >= 0 && index < widget.labels.length) {
                      return widget.labels[index];
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  margin: 16, // Adjust the margin for leftTitles
                  reservedSize: 60, // Adjust the reservedSize for leftTitles
                  getTitles: (value) {
                    return value.toInt().toString();
                  },
                ),
                topTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitles: (value) {
                    return ''; // Remove the word "liters" from y-axis labels
                  },
                ),
              ),
              maxY: widget.waterUsage.reduce(max).toDouble() + 50, // Adjust the maxY for more space
              barGroups: widget.waterUsage
                  .asMap()
                  .entries
                  .map(
                    (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          y: entry.value.toDouble() * value, // Use the animated value for the height
                          colors: [Colors.blue],
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: YourWaterUsageScreen(selectedGoal: 'Novice'),
  ));
}
