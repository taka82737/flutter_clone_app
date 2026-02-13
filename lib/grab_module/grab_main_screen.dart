import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'activity_screen.dart';
import 'messages_screen.dart';
import 'payment_screen.dart';
import 'profile_screen.dart';

class GrabMainScreen extends StatefulWidget {
  const GrabMainScreen({Key? key}) : super(key: key);

  @override
  State<GrabMainScreen> createState() => _GrabMainScreenState();
}

class _GrabMainScreenState extends State<GrabMainScreen> {
  int _currentIndex = 0;

  final screens = [
    GrabHomeScreen(),
    ActivityScreen(),
    MessagesScreen(),
    PaymentScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
