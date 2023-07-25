import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bottom_nav_bar.dart';

class ChooseUserScreen extends StatelessWidget {
  void navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who's Using ?",
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
                // Handle icon 1 click here
                print("user1_avatar clicked");
                navigateToHomeScreen(context);
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
                print("user2_avatar clicked");
                navigateToHomeScreen(context);
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
                // Handle icon 3 click here
                print("user3_avatar clicked");
                navigateToHomeScreen(context);
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
