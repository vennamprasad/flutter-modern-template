import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/news_article.dart';
import '../../data/repositories/news_repository_impl.dart';
import 'news_pagination_state.dart';

part 'news_controller.g.dart';

@riverpod
class NewsController extends _$NewsController {
  int _currentPage = 1;
  bool _isLoadingMore = false;
  static const int _pageSize = 20;

  @override
  Stream<List<NewsArticle>> build() {
    final repository = ref.watch(newsRepositoryProvider);
    return repository.getNewsStream();
  }

  /// Trigger a refresh (Page 1).
  Future<void> refresh() async {
    _currentPage = 1;
    // Reset "Has More"
    ref.read(newsPaginationStateProvider.notifier).setHasMore(true);

    final repository = ref.read(newsRepositoryProvider);
    await repository.refreshNews();
  }

  /// Load next page.
  Future<void> loadMore() async {
    if (_isLoadingMore) return;

    // Check if we already know there's no more data
    final hasMore = ref.read(newsPaginationStateProvider);
    if (!hasMore) return;

    _isLoadingMore = true;
    try {
      final repository = ref.read(newsRepositoryProvider);
      final nextPage = _currentPage + 1;
      final fetchedCount = await repository.loadMoreNews(nextPage);

      _currentPage = nextPage;

      // If we fetched fewer than page size, we reached the end
      if (fetchedCount < _pageSize) {
        ref.read(newsPaginationStateProvider.notifier).setHasMore(false);
      }
    } finally {
      _isLoadingMore = false;
    }
  }
}
