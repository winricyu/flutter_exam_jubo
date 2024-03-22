import 'package:flutter_exam_jubo/features/user/data/user.dart';

abstract interface class UserRepository {
  ///新增住民
  Future<void> addUser(User user);

  ///更新住民資料
  Future<void> updateUser(User user);

  ///刪除
  Future<void> deleteUser(User user);

  ///取得所有住民
  Future<List<User>> getAllUsers();

  ///計算早餐數量
  Future<int> countBreakfast();

  ///計算午餐數量
  Future<int> countLunch();

  ///計算晚餐數量
  Future<int> countDinner();
}
