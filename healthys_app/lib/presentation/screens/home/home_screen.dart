import 'package:flutter/material.dart';
import 'package:healthys_app/presentation/screens/entrants/entrants_screen.dart';
import 'package:healthys_app/presentation/screens/begudes/begudes_screen.dart';
import 'package:healthys_app/presentation/screens/principals/principals_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    EntrantsScreen(),
    PrincipalsScreen(),
    BegudesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/img/healthys_logo.png")),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Entrants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Principals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Begudes',
          ),
        ],
      ),
    );
  }
}
