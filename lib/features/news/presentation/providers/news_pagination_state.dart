import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_pagination_state.g.dart';

@riverpod
class NewsPaginationState extends _$NewsPaginationState {
  @override
  bool build() {
    return true; // Initially, we assume there is more data
  }

  void setHasMore(bool hasMore) {
    state = hasMore;
  }
}
