import 'package:flutter/material.dart';
import 'screens/stats_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          CameraScreen(),
          StatsScreen(),
          SettingsScreen(),
          ProfileScreen(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.camera_alt),
            title: "Camera",
            activeColorPrimary: Colors.deepPurple,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.bar_chart),
            title: "Stats",
            activeColorPrimary: Colors.deepPurple,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.settings),
            title: "Settings",
            activeColorPrimary: Colors.deepPurple,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.person),
            title: "Profile",
            activeColorPrimary: Colors.deepPurple,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        confineInSafeArea: true,
        backgroundColor: Colors.black,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.black,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}