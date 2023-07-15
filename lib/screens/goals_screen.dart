import 'package:flutter/material.dart';


class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals Screen'),
      ),
      body: Center(
        child: const Text('This is the goals screen.'),
      ),
    );
  }
}
