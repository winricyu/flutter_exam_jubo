import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_index_provider.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() {
    return 0;
  }

  void changeIndex(int index) {
    state = index;
  }
}
