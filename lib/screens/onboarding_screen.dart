import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'onboarding_contents.dart';
import 'size_config.dart';
import 'choose_user_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffFFE5DE),
    Color.fromARGB(255, 238, 214, 175),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage == index ? Color(0xFF000000) : Colors.grey,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  void navigateToChooseUserScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseUserScreen()),
    );
  }

  void skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChooseUserScreen()),
    );
  }

ElevatedButton _buildSkipButton() {
  return ElevatedButton(
    onPressed: skipOnboarding,
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25), // Adjust the padding
    ),
    child: const Text(
      "SKIP", // Add the text to be displayed on the button
      style: TextStyle(color: Colors.white, fontSize: 19.5), // Increase font size by 2.0
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 15 : 17.5,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                    _currentPage + 1 == contents.length
                        ? Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: navigateToChooseUserScreen,
                              child: const Text(
                                "NEXT",
                                style: TextStyle(color: Colors.white, fontSize: 19.5), // Increase font size by 2.0
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSkipButton(), // Use the same style as the "Next" button
                                ElevatedButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: const Text(
                                    "NEXT",
                                    style: TextStyle(color: Colors.white, fontSize: 19.5), // Increase font size by 2.0
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
