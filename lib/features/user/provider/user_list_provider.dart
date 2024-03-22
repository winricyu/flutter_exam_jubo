import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/meal/provider/breakfast_provider.dart';
import 'package:flutter_exam_jubo/features/meal/provider/dinner_provider.dart';
import 'package:flutter_exam_jubo/features/meal/provider/lunch_provider.dart';
import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_datasource.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_repository.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_repository_sql_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';

@riverpod
class UserList extends _$UserList {
  late final UserRepository _repository;

  @override
  List<User> build() {
    _repository = UserRepositorySqlImpl(UserDatasource());
    loadUsers();
    return [];
  }

  void loadUsers() async {
    try{
      final users = await _repository.getAllUsers();
      state = users;
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> addUser(User user) async {
    try{
      await _repository.addUser(user);
      loadUsers();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> updateUser(User user) async {
    try{
      await _repository.updateUser(user);
      countMeals();
      loadUsers();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> deleteUser(User user) async {
    try{
      await _repository.deleteUser(user);
      countMeals();
      loadUsers();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void countMeals(){
    ref.read(breakfastCounterProvider.notifier).count();
    ref.read(lunchCounterProvider.notifier).count();
    ref.read(dinnerCounterProvider.notifier).count();
  }
}
