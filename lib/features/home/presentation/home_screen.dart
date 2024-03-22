import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/chart/presentation/chart_screen.dart';
import 'package:flutter_exam_jubo/features/home/provider/navigation_index_provider.dart';
import 'package:flutter_exam_jubo/features/meal/presentation/meal_screen.dart';
import 'package:flutter_exam_jubo/features/user/presentation/user_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
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

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: _navItems,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}
