import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  void navigateToOnboardingScreen(BuildContext context) {
    // Navigate to the OnboardingScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  void click2() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              SizedBox(
                height: 200,
                width: 300,
                child: Image.asset("assets/HydroMindLogo.png"),
              ),
              const SizedBox(height: 10),
              Container(
                width: 325,
                padding: const EdgeInsets.all(16.0), // Add some padding for better spacing
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 260,
                      height: 60,
                      child: const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.red,
                          ),
                          labelText: "Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 260,
                      height: 60,
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.eyeSlash,
                            color: Colors.red,
                          ),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: click2,
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => navigateToOnboardingScreen(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      "Or Login using Social Media Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: click2,
                          icon: const Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: click2,
                          icon: const Icon(FontAwesomeIcons.google, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: click2,
                          icon: const Icon(FontAwesomeIcons.twitter, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: click2,
                          icon: const Icon(FontAwesomeIcons.linkedinIn, color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50), // Add some additional space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
