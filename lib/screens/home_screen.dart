import 'package:flutter/material.dart';
import 'goals_screen.dart';
import 'your_water_usage_screen.dart';
import 'globals.dart';

class HomeScreen extends StatefulWidget {
  final String selectedGoal;

  const HomeScreen({Key? key, required this.selectedGoal}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGoal = '';

  final String janeFooImagePath = "assets/images/user1_avatar.jpg";
  final String johnFooImagePath = "assets/images/user2_avatar.jpg"; 
  final String jerryFooImagePath = "assets/images/user3_avatar.jpg";

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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0), // Add padding to the top of the text
                  child: Text(
                    'Welcome to HydroMind!',
                    style: TextStyle(
                      fontSize: 14, // Increase font size to 14
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'This App is designed to be simple and easy to use.',
                  style: TextStyle(fontSize: 14), // Increase font size to 14
                ),
                SizedBox(height: 12),
                Text(
                  '1. The button with the target icon will take you to the Goals Screen. You can select the goal you want and our algorithm will automatically set the newly recommended water saving target for you.',
                  style: TextStyle(fontSize: 14), // Increase font size to 14
                ),
                SizedBox(height: 12),
                Text(
                  '2. The button with the shower icon will take you to Your Water Usage Screen. You can discover how much water you have used each day and find out the savings target that is set by our algorithm.',
                  style: TextStyle(fontSize: 14), // Increase font size to 14
                ),
              ],
            ),
          ),
          actions: [
            Center(
              // Move the Close button to the center
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Thanks!', style: TextStyle(fontSize: 14)), // Increase font size to 14
              ),
            ),
          ],
          backgroundColor: Colors.white,
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
        // Set the image path based on the selectedUsername
    String imagePath = '';
    if (Globals.selectedUsername == 'Jane Foo') {
      imagePath = janeFooImagePath;
    } else if (Globals.selectedUsername == 'John Foo') {
      imagePath = johnFooImagePath;
    } else if (Globals.selectedUsername == 'Jerry Foo') {
      imagePath = jerryFooImagePath;
    }

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
          },
        ),
       actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: imagePath.isEmpty
                  ? AssetImage("assets/images/placeholder_avatar.jpg") 
                  : AssetImage(imagePath),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300, // Widen the Your Goals button
                child: widget.selectedGoal.isNotEmpty
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoalsScreen(
                                onConfirmationChanged: updateGoalConfirmation,
                                selectedGoal: widget.selectedGoal,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200, // Adjust the width of the image
                              height: 200, // Adjust the height of the image
                              child: Image.asset(
                                'assets/images/target.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your Goals: (${widget.selectedGoal})',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF7C8D9A), // Set the Your Goals button color
                          onPrimary: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                selectedGoal: widget.selectedGoal,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300, // Widen the Your Water Usage button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            YourWaterUsageScreen(selectedGoal: widget.selectedGoal),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200, // Adjust the width of the image
                        height: 200, // Adjust the height of the image
                        child: Image.asset(
                          'assets/images/shower.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 60,
                      ),
                      const Text(
                        'Your Water Usage',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2C3D4D), // Set the Your Water Usage button color
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startTutorial,
        child: Icon(Icons.help_outline, color: Colors.grey),
        tooltip: 'Show Tutorial',
        backgroundColor: Colors.white,
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
            width: 200, // Adjust the width of the image
            height: 200, // Adjust the height of the image
            child: Image.asset(
              'assets/images/target.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Goals',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF7C8D9A), // Set the Your Goals button color
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
