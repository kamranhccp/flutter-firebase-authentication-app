import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/pages/flutter_home.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';
import 'package:flutter_firebase_email_pass_auth/pages/profile.dart';
import 'package:flutter_firebase_email_pass_auth/pages/settings.dart';

import '../constants/global_constants.dart';
import '../widgets_bottom_bar/change_password.dart';

class FlutterHomeMain extends StatefulWidget {
  const FlutterHomeMain({Key? key}) : super(key: key);

  @override
  FlutterHomeMainState createState() => FlutterHomeMainState();
}

class FlutterHomeMainState extends State<FlutterHomeMain> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const FlutterHome(),
    const ChangePassword(),
    const FirebaseSettings(),
    const FirestoreProfile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.deepPurple,
        elevation: 5.0,
        selectedItemColor: Colors.purpleAccent,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(
              AssetImage('assests/images/home.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Password',
            icon: ImageIcon(
              AssetImage('assests/images/change-password.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: ImageIcon(
              AssetImage('assests/images/settings.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: ImageIcon(
              AssetImage("assests/images/bottom-profile.png")
            ),
          ),
        ],
      ),
    );
  }
}