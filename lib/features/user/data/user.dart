import 'package:flutter_exam_jubo/features/user/repository/user_table_keys.dart';

/// id : 123
/// name : "住民姓名"
/// birthday : 648182825
/// breakfast : true
/// lunch : false
/// dinner : true

class User {
  int? id;
  String? name;
  int? birthday;
  bool? breakfast;
  bool? lunch;
  bool? dinner;

  DateTime get birthDate =>
      DateTime.fromMillisecondsSinceEpoch(birthday ?? -999);

  User({
    this.id,
    this.name,
    this.birthday,
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  User.fromJson(dynamic json) {
    id = json[UserKeys.columnId];
    name = json[UserKeys.columnName];
    birthday = json[UserKeys.columnBirthday];
    breakfast = json[UserKeys.columnBreakfast] == 1 ? true : false;
    lunch = json[UserKeys.columnLunch] == 1 ? true : false;
    dinner = json[UserKeys.columnDinner] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[UserKeys.columnId] = id;
    map[UserKeys.columnName] = name;
    map[UserKeys.columnBirthday] = birthday;
    map[UserKeys.columnBreakfast] = (breakfast ?? false) ? 1 : 0;
    map[UserKeys.columnLunch] = (lunch ?? false) ? 1 : 0;
    map[UserKeys.columnDinner] = (dinner ?? false) ? 1 : 0;
    return map;
  }

  User copyWith({
    int? id,
    String? name,
    int? birthday,
    bool? breakfast,
    bool? lunch,
    bool? dinner,
  }) =>
      User(
        id: id ?? id,
        name: name ?? name,
        birthday: birthday ?? birthday,
        breakfast: breakfast ?? breakfast,
        lunch: lunch ?? lunch,
        dinner: dinner ?? dinner,
      );
}
