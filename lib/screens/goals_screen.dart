import 'package:flutter/material.dart';
import 'home_screen.dart';

class GoalsScreen extends StatelessWidget {
  final void Function(bool, String)? onConfirmationChanged;
  final String selectedGoal;

  const GoalsScreen({
    Key? key,
    required this.onConfirmationChanged,
    required this.selectedGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGoalBox(
              'assets/images/goal1.png',
              'Novice',
              context,
            ),
            _buildGoalBox(
              'assets/images/goal2.png',
              'Seasoned',
              context,
            ),
            _buildGoalBox(
              'assets/images/goal3.png',
              'Elite',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalBox(String imagePath, String description, BuildContext context) {
    return InkWell(
      onTap: () {
        _showConfirmationDialog(context, description);
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(imagePath),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String goal) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              if (onConfirmationChanged != null) {
                onConfirmationChanged!(true, goal); // Notify the callback function in HomeScreen
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    selectedGoal: goal, // Pass the selected goal description back to HomeScreen
                  ),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
}