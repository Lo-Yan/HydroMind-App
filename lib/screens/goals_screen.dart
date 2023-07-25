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

  void startTutorial(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tutorial'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to the Goals Screen!'),
              const SizedBox(height: 8),
              Text('This screen contains different water-saving goals for users. Novice being the easiest (slowest progress) and Elite being the hardest (fastest progress).'),
              const SizedBox(height: 8),
              Text('1. Tap on a goal box to select a water-saving goal.'),
              const SizedBox(height: 8),
              Text('2. After selecting a goal, you will be prompted to confirm your selection.'),
              const SizedBox(height: 8),
              Text('3. Upon confirmation, the selected goal will be passed back to the HomeScreen.'),
              const SizedBox(height: 8),
              Text('4. To check whether the selected goal is in place, it will be displayed in the HomeScreen.'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Goals',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white, // Set the title color to white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Set the background color of the app bar to black
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set the back button color to white
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              noviceColor: Color(0xFF5A7D98), // Light Blue for Novice button
            ),
            _buildGoalBox(
              'assets/images/goal2.png',
              'Seasoned',
              context,
              seasonedColor: Color(0xFF3D5669), // Blue for Seasoned button
            ),
            _buildGoalBox(
              'assets/images/goal3.png',
              'Elite',
              context,
              eliteColor: Color(0xFF1A252E), // Blue for Elite button
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startTutorial(context),
        child: Icon(Icons.help_outline),
        tooltip: 'Show Tutorial',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
Widget _buildGoalBox(String imagePath, String description, BuildContext context, {Color? noviceColor, Color? seasonedColor, Color? eliteColor}) {
  return InkWell(
    onTap: () {
      _showConfirmationDialog(context, description);
    },
    child: Container(
      width: double.infinity,
      height: 180, // Set the height to match the height of the images
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: description == 'Novice'
            ? noviceColor
            : (description == 'Seasoned'
                ? seasonedColor
                : (description == 'Elite' ? eliteColor : null)),
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
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: description,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
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