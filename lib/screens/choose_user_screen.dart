import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bottom_nav_bar.dart';
import 'globals.dart';

class ChooseUserScreen extends StatelessWidget {
  void navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  void onTapUserAvatar(BuildContext context, String username) {
    Globals.selectedUsername = username; // Update the selectedUsername globally
    print('Selected Username: ${Globals.selectedUsername}');
    navigateToHomeScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who's Using?",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                onTapUserAvatar(context, "Jane Foo"); // Call the function with the selected username
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/user1_avatar.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jane Foo",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onTapUserAvatar(context, "John Foo"); // Call the function with the selected username
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/user2_avatar.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Foo",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onTapUserAvatar(context, "Jerry Foo"); // Call the function with the selected username
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/user3_avatar.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jerry Foo",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
