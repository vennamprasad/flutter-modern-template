class NewsArticle {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final DateTime publishedAt;

  NewsArticle({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.publishedAt,
  });
}
