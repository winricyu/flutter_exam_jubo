extension DateTimeConvert on DateTime {
  /// 計算年齡
  int get calculateAge {
    final diffDays = DateTime.now().difference(this).inDays;
    final age = (diffDays / 366).floor();
    return age;
  }
}
