/*
This is the homepage screen where the user will be directed to after choosing their profile.
*/

import 'package:flutter/material.dart';
import 'goals_screen.dart';
import 'your_water_usage_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false, // Add this line to remove the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GoalsScreen(),
                  ),
                );
              },
              child: const Text('Go to Goals Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YourWaterUsageScreen(),
                  ),
                );
              },
              child: const Text('Go to Your Water Usage Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
