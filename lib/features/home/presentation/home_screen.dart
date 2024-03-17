import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/chart/presentation/chart_screen.dart';
import 'package:flutter_exam_jubo/features/meal/presentation/meal_screen.dart';
import 'package:flutter_exam_jubo/features/user/presentation/user_screen.dart';

class MyHomePage extends StatelessWidget {

  final _navItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_outlined), label: '住民名單'),
    const BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: '供餐名單'),
    const BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: '供餐統計'),
  ];

  final _screens = [
    const UserScreen(),
    const MealScreen(),
    const ChartScreen(),
  ];

  var _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: _navItems,
        onTap: (index) {
            _currentIndex = index;
        },
      ),
    );
  }
}
