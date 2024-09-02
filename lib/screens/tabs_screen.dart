import 'package:exun_app_21/screens/contact_screen.dart';
import 'package:exun_app_21/screens/members_screen.dart';
import 'package:exun_app_21/screens/profile_screen.dart';
import 'package:exun_app_21/screens/schedule_screen.dart';
import 'package:exun_app_21/screens/talks_screen.dart';

import '../firebase_notification_handler.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './about_screen.dart';
import 'alumni_screen.dart';
import 'faculty_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class Page {
  Widget page;
  String title;
  IconData icon;

  Page({
    required this.page,
    required this.title,
    required this.icon,
  });
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Page> _pages = [
    Page(
      page: const HomeScreen(),
      title: "Notifications",
      icon: Icons.home,
    ),
    Page(
      // page: const LoginScreen(),
     //todo: uncomment and delete loginscreen()
     //page: const ScheduleScreen(),
      page: ProfileScreen(),
      title: "Schedule",
      icon: Icons.calendar_today,
    ),
    // Page(
    //   page: const HomeScreen(),
    //   title: "Leaderboard",
    //   icon: Icons.leaderboard,
    // ),
    Page(
      page: const AboutScreen(),
      title: "About us",
      icon: Icons.info,
    ),
  ];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseNotifications().setUpFirebase();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex].title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_selectedPageIndex].page,
      bottomNavigationBar: BottomNavigationBar( //todo: remove bottom nav
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        items: _pages
            .map(
              (page) => BottomNavigationBarItem(
                icon: Icon(page.icon),
                label: page.title,
              ),
            )
            .toList(),
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[300],
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        // fixedColor: Colors.blue,
      ),
    );
  }
}
