import 'package:flutter/material.dart';

class YourWaterUsageScreen extends StatefulWidget {
  const YourWaterUsageScreen({Key? key}) : super(key: key);

  @override
  _YourWaterUsageScreenState createState() => _YourWaterUsageScreenState();
}

class _YourWaterUsageScreenState extends State<YourWaterUsageScreen> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Water Usage Screen'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _onNavItemTapped(0);
                  },
                  child: Container(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Weeks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _onNavItemTapped(1);
                  },
                  child: Container(
                    color: _selectedIndex == 1 ? Colors.blue : Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Months',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _selectedIndex == 0 ? 'This is the weeks screen.' : 'This is the months screen.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
