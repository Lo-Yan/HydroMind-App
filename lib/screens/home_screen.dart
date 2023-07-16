import 'package:flutter/material.dart';
import 'goals_screen.dart';
import 'your_water_usage_screen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedGoal;

  const HomeScreen({Key? key, required this.selectedGoal}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGoal = '';

  void updateGoalConfirmation(bool confirmed, String goal) {
    if (confirmed) {
      setState(() {
        selectedGoal = goal;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedGoal = widget.selectedGoal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedGoal.isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalsScreen(
                              onConfirmationChanged: updateGoalConfirmation,
                              selectedGoal: selectedGoal,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'assets/images/target.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Goals: ($selectedGoal)',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amberAccent,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  : GoalsButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalsScreen(
                              onConfirmationChanged: updateGoalConfirmation,
                              selectedGoal: selectedGoal,
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourWaterUsageScreen(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        'assets/images/shower.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your Water Usage',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoalsButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/images/target.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Go to Goals Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.amberAccent,
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
