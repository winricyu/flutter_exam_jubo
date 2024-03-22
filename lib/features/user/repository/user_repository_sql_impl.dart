import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_datasource.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_repository.dart';

class UserRepositorySqlImpl implements UserRepository {
  final UserDatasource _datasource;

  UserRepositorySqlImpl(this._datasource);

  @override
  Future<void> addUser(User user) async {
    try {
      await _datasource.addUser(user);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      await _datasource.deleteUser(user);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      return await _datasource.getAllUsers();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await _datasource.updateUser(user);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> countBreakfast() async {
    try {
      final counts = await _datasource.countBreakfast();
      return counts;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> countLunch() async {
    try {
      final counts = await _datasource.countLunch();
      return counts;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> countDinner() async {
    try {
      final counts = await _datasource.countDinner();
      return counts;
    } catch (e) {
      throw e.toString();
    }
  }
}
