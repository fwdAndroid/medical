import 'package:flutter/material.dart';
import 'package:medical/dashboard/screens/chat_screen.dart';
import 'package:medical/dashboard/screens/home.dart';
import 'package:medical/dashboard/screens/profile_screen.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeScreen(), ChatScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    "assets/homeblue.png",
                    height: 25,
                  )
                : Image.asset(
                    "assets/g.png",
                    height: 25,
                  ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    "assets/bookingblue.png",
                    height: 25,
                  )
                : Image.asset(
                    "assets/email.png",
                    height: 25,
                  ),
            label: '',
          ),
          BottomNavigationBarItem(
              label: "",
              icon: _currentIndex == 2
                  ? Image.asset(
                      "assets/chatblue.png",
                      height: 25,
                    )
                  : Image.asset(
                      "assets/chatno.png",
                      height: 25,
                    )),
        ],
        selectedItemColor: Color(0xff199A8E),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // Set your desired background color here
      ),
    );
  }
}
