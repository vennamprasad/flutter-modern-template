import '../entities/news_article.dart';

abstract class NewsRepository {
  /// Returns a reactive stream of news from the Local Database.
  Stream<List<NewsArticle>> getNewsStream();

  /// Fetches fresh news from Remote and updates Local Database.
  Future<void> refreshNews();

  /// Fetches next page of news and appends to Local Database.
  /// Returns the number of items fetched.
  Future<int> loadMoreNews(int page);
}
