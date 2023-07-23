import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bottom_nav_bar.dart';

class User {
  final String username;
  final String avatarUrl;

  User({required this.username, required this.avatarUrl});
}

final List<User> users = [
  User(username: "Foo Shu Hui", avatarUrl: "assets/images/user1_avatar.jpg"),
  User(username: "Shu Hui Foo", avatarUrl: "assets/images/user2_avatar.jpg"),
  User(username: "Hui Shu Foo", avatarUrl: "assets/images/user3_avatar.jpg"),
];

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
        title: Text('Choose User'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                // Handle user selection here
                print("Selected user: ${user.username}");
                // Call the navigateToHomeScreen function when a user is selected
                navigateToHomeScreen(context);
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(user.avatarUrl),
                  ),
                  title: Text(user.username),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
