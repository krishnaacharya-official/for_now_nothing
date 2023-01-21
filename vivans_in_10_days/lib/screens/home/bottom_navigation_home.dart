import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/screens/home/categories_all.dart';
import 'package:vivans_in_10_days/screens/home/home.dart';
import 'package:vivans_in_10_days/screens/home/search_screen.dart';
import 'package:vivans_in_10_days/screens/profile/profile_%20main.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  final List _screens = [
    const Home(),
    SearchScreen(),
    const CategoriesScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            // useLegacyColorScheme: false,
            // selectedItemColor: Colors.blue[700],
            // selectedFontSize: 13,
            // unselectedFontSize: 13,
            selectedFontSize: 12,
            // iconSize: 30,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: _currentIndex == 0
                    ? const Icon(Icons.home_filled)
                    : const Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: "Search",
                icon: _currentIndex == 1
                    ? const Icon(Icons.search_rounded)
                    : const Icon(Icons.search_outlined),
              ),
              BottomNavigationBarItem(
                label: "Categories",
                icon: _currentIndex == 2
                    ? const Icon(Icons.grid_view_rounded)
                    : const Icon(Icons.grid_view_outlined),
              ),
              BottomNavigationBarItem(
                label: "Account",
                icon: _currentIndex == 3
                    ? const Icon(Icons.account_circle_rounded)
                    : const Icon(Icons.account_circle_outlined),
              ),
            ]));
  }
}
