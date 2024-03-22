import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/common_widgets/user_dialog.dart';
import 'package:flutter_exam_jubo/common_widgets/user_tile.dart';
import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:flutter_exam_jubo/features/user/provider/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userListProvider);
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popAddUserDialog().then((value) {
            if (value is User) {
              ref.read(userListProvider.notifier).addUser(value);
            }
          });
        },
        tooltip: '新增住民',
        child: const Icon(Icons.add),
      ),
      body: users.isNotEmpty
          ? ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final user = users[index];
                return UserTile(
                  tileType: TileType.delete,
                  user: user,
                  onDeleteClick: () {
                    popDeleteUserDialog(user.name!).then((value) {
                      if (value == true) {
                        ref.read(userListProvider.notifier).deleteUser(user);
                      }
                    });

                  },
                );
              })
          : SizedBox.expand(
              child: Center(
                  child: Text(
                '請新增住民資料',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.grey),
              )),
            ),
    );
  }

  ///顯示新增住民視窗
  Future<User?> popAddUserDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const UserDialog(),
      );

  ///顯示刪除確認視窗
  Future<bool?> popDeleteUserDialog(String name) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: const Text('刪除'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('刪除'),
              ),
            ],
            content: Text('確定要刪除 [$name] 住民資料？'),
          ));
}
