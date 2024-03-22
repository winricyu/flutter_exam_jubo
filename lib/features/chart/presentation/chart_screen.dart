import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/meal/provider/breakfast_provider.dart';
import 'package:flutter_exam_jubo/features/meal/provider/dinner_provider.dart';
import 'package:flutter_exam_jubo/features/meal/provider/lunch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartScreen extends ConsumerWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakfastCounts = ref.watch(breakfastCounterProvider);
    final lunchCounts = ref.watch(lunchCounterProvider);
    final dinnerCounts = ref.watch(dinnerCounterProvider);

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '早餐：$breakfastCounts',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '午餐：$lunchCounts',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '晚餐：$dinnerCounts',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
