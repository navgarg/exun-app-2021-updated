import 'package:exun_app_21/screens/contact_screen.dart';
import 'package:exun_app_21/screens/login_screen.dart';
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
      page: ScheduleScreen(),
      title: "Schedule",
      icon: Icons.calendar_today,
    ),
    Page(
      page: TalksScreen(),
      title: "Exun Talks",
      icon: Icons.public,
    ),

    Page(
      page: const AboutScreen(),
      title: "About us",
      icon: Icons.info,
    ),

    Page(
      page: ProfileScreen(),
      title: "Profile",
      icon: Icons.account_circle,
    ),
    Page(
      page: const MembersScreen(),
      title: "Members",
      icon: Icons.group,
    ),
    Page(
      page: const AlumniScreen(),
      title: "Alumni",
      icon: Icons.diversity_3,
    ),
    Page(
      page: const FacultyScreen(),
      title: "Faculty",
      icon: Icons.school,
    ),
    Page(
      page: const ContactsScreen(),
      title: "Contacts",
      icon: Icons.alternate_email,
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = <Widget>[];
    for (var i = 0; i < _pages.length; i++) {
      var d = _pages[i];
      drawer.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedPageIndex,
            onTap: () => _selectPage(i),
          )
      );
    }

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
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(accountName: Text("John Doe"), accountEmail: null), //todo: get name from firebase auth
            Column(
              children: drawer,
            )

          ],
        ),

      ),
      // bottomNavigationBar: BottomNavigationBar( //todo: remove bottom nav
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   onTap: _selectPage,
      //   items: _pages
      //       .map(
      //         (page) => BottomNavigationBarItem(
      //           icon: Icon(page.icon),
      //           label: page.title,
      //         ),
      //       )
      //       .toList(),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   unselectedItemColor: Colors.grey[300],
      //   selectedItemColor: Colors.white,
      //   currentIndex: _selectedPageIndex,
      //   fixedColor: Colors.blue,
      // ),
    );
  }

}
