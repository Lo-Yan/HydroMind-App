import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Add this line to remove the back button
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: const Text(
          'This is the Profile.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
