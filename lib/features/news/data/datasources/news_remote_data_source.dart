import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/news_article.dart';

part 'news_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
NewsRemoteDataSource newsRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NewsRemoteDataSource(apiClient);
}

class NewsRemoteDataSource {
  final ApiClient _apiClient;

  NewsRemoteDataSource(this._apiClient);

  /// Fetches news with pagination (JSONPlaceholder).
  /// [page] is 1-based index (1, 2, 3...)
  /// [limit] is items per page (default 20)
  Future<List<NewsArticle>> fetchNews({int page = 1, int limit = 20}) async {
    // JSONPlaceholder uses _start (0-based) and _limit
    final start = (page - 1) * limit;

    try {
      final response = await _apiClient.client.get(
        'https://jsonplaceholder.typicode.com/posts',
        queryParameters: {
          '_start': start,
          '_limit': limit,
        },
      );

      final List<dynamic> data = response.data;

      return data.map((json) {
        return NewsArticle(
          id: json['id'].toString(),
          title: json['title'],
          description: json['body'],
          // Random image based on ID
          imageUrl: 'https://picsum.photos/seed/${json['id']}/300/200',
          publishedAt: DateTime.now(), // Mock current time
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
