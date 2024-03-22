import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/common_widgets/user_tile.dart';
import 'package:flutter_exam_jubo/features/user/provider/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: users.isNotEmpty
          ? ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final user = users[index];
                return UserTile(
                    tileType: TileType.meals,
                    user: user,
                    onChange: (user) {
                      ref.read(userListProvider.notifier).updateUser(user);
                    });
              })
          : SizedBox.expand(
              child: Center(
                  child: Text(
                '無住民資料',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.grey),
              )),
            ),
    );
  }
}
