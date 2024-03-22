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
      body: ListView.builder(
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
          }),
    );
  }
}
