import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_datasource.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_repository.dart';
import 'package:flutter_exam_jubo/features/user/repository/user_repository_sql_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'breakfast_provider.g.dart';

@riverpod
class BreakfastCounter extends _$BreakfastCounter{
  late final UserRepository _repository;

  @override
  int build(){
    _repository = UserRepositorySqlImpl(UserDatasource());
    count();
    return 0;
  }

  void count()async {
    try{
     final counts = await _repository.countBreakfast();
     debugPrint('BreakfastCounter.count, $counts');
     state = counts;
    }catch(e){
      debugPrint(e.toString());
    }
  }

}