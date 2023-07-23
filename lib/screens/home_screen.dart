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

  // Move the updateGoalConfirmation function to the HomeScreen class
  void updateGoalConfirmation(bool confirmed, String goal) {
    if (confirmed) {
      setState(() {
        selectedGoal = goal;
      });
    }
  }

  void startTutorial() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tutorial'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to HydroMind!'),
              const SizedBox(height: 8),
              Text('This App is designed to be simple and easy to use.'),
              const SizedBox(height: 8),
              Text('1. The button with the target icon will take you to the Goals Screen. You can select the goal you want and our algorithm will automatically set the newly recommended water saving target for you.'),
              const SizedBox(height: 8),
              Text('2. The button with the shower icon will take you to Your Water Usage Screen. You can discover how much water you have used each day and find out the savings target that is set by our algorithm.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

void showAddDeviceNotification() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Device'),
          content: Text('Please add your device to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
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
        leading: PlusButton(
          onPressed: () {
            showAddDeviceNotification();
          }, // Show the notification when the plus button is pressed.
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.selectedGoal.isNotEmpty // Use widget.selectedGoal here
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalsScreen(
                              onConfirmationChanged: updateGoalConfirmation,
                              selectedGoal: widget.selectedGoal, // Pass the selectedGoal to GoalsScreen
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
                            'Your Goals: (${widget.selectedGoal})', // Use widget.selectedGoal here
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
                              selectedGoal: widget.selectedGoal, // Pass the selectedGoal to GoalsScreen
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
                      builder: (context) =>
                          YourWaterUsageScreen(selectedGoal: widget.selectedGoal), // Pass the selectedGoal to YourWaterUsageScreen
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
      floatingActionButton: FloatingActionButton(
        onPressed: startTutorial, // Call the function to show the tutorial dialog
        child: Icon(Icons.help_outline), // Replace with your desired icon for the "?"
        tooltip: 'Show Tutorial', // Tooltip message for the button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

class PlusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlusButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: Colors.white),
      onPressed: onPressed,
    );
  }
}

