import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/common_widgets/user_tile.dart';
import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:flutter_exam_jubo/features/user/provider/user_list_provider.dart';
import 'package:flutter_exam_jubo/utils/datetime_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime? _birthDate;
  final _birthTextController = TextEditingController();
  final _ageTextController = TextEditingController();

  @override
  void dispose() {
    _birthTextController.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userListProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popAddUserDialog().then((value) {
            if (value is User) {
              ref.read(userListProvider.notifier).addUser(value);
            }

            setState(() {
              _birthDate = null;
              _birthTextController.clear();
              _ageTextController.clear();
            });
          });
        },
        tooltip: '新增住民',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
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
          }),
    );
  }

  ///姓名欄位
  Widget nameField() => TextFormField(
        decoration: const InputDecoration(
            hintText: '輸入姓名', border: OutlineInputBorder(), labelText: '姓名'),
        validator: (value) {
          if ((value?.isEmpty ?? true) == true) {
            return '姓名不能為空';
          }
          return null;
        },
        onSaved: (value) {
          if ((value?.isEmpty ?? true) == false) {
            _name = value!;
          }
        },
      );

  ///生日欄位
  Widget birthField() => TextFormField(
        controller: _birthTextController,
        readOnly: true,
        decoration: const InputDecoration(
          hintText: '生日',
          labelText: '出生年月日',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if ((value?.isEmpty ?? true) == true) {
            return '生日不可為空';
          }
          return null;
        },
        onTap: () {
          popDatePicker().then((value) {
            if (value == null) return;
            _birthTextController.text = DateFormat.yMd('zh_TW').format(value);
            _ageTextController.text =
                (_birthDate?.calculateAge.toString() ?? 'age null');
          });
        },
      );

  ///年齡欄位
  Widget ageField() => TextFormField(
        controller: _ageTextController,
        enabled: false,
        decoration: const InputDecoration(
          labelText: '年齡',
        ),
      );

  ///顯示日期選擇介面
  Future<DateTime?> popDatePicker() => showCupertinoModalPopup(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surface,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('取消')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(_birthDate);
                      },
                      child: const Text('確定')),
                ],
              ),
              const Gap(16),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.ymd,
                  initialDateTime: _birthDate ?? DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (date) {
                    _birthDate = date;
                  },
                ),
              ),
            ],
          ),
        );
      });

  ///顯示新增住民視窗
  Future<User?> popAddUserDialog() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: const Text('新增住民'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop(User(
                        name: _name,
                        birthday: _birthDate!.millisecondsSinceEpoch));
                  }
                },
                child: const Text('新增住民'),
              ),
            ],
            content: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    nameField(),
                    const Gap(16),
                    birthField(),
                    const Gap(16),
                    ageField(),
                  ],
                ),
              ),
            ),
          ));

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
