import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/news_article.dart' as domain;
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

part 'news_repository_impl.g.dart';

@Riverpod(keepAlive: true)
NewsRepository newsRepository(Ref ref) {
  final database = ref.watch(db.appDatabaseProvider);
  final remoteDataSource = ref.watch(newsRemoteDataSourceProvider);
  return NewsRepositoryImpl(database, remoteDataSource);
}

class NewsRepositoryImpl implements NewsRepository {
  final db.AppDatabase _database;
  final NewsRemoteDataSource _remoteDataSource;

  NewsRepositoryImpl(this._database, this._remoteDataSource);

  @override
  Stream<List<domain.NewsArticle>> getNewsStream() {
    return _database.watchAllNews().map((rows) {
      return rows.map((row) => _mapToDomain(row)).toList();
    });
  }

  @override
  Future<void> refreshNews() async {
    // 1. Fetch Page 1
    final remoteArticles = await _remoteDataSource.fetchNews(page: 1);

    // 2. Map
    final inserts = _mapToInserts(remoteArticles);

    // 3. Transaction: Clear old & Insert new
    await _database.transaction(() async {
      await _database.clearNews();
      await _database.insertNews(inserts);
    });
  }

  @override
  Future<int> loadMoreNews(int page) async {
    // 1. Fetch Page N
    final remoteArticles = await _remoteDataSource.fetchNews(page: page);

    // 2. Map
    final inserts = _mapToInserts(remoteArticles);

    // 3. Insert (Append)
    await _database.insertNews(inserts);

    return remoteArticles.length;
  }

  List<db.NewsArticlesCompanion> _mapToInserts(
      List<domain.NewsArticle> articles) {
    return articles.map((article) {
      return db.NewsArticlesCompanion.insert(
        id: article.id,
        title: article.title,
        description: Value(article.description),
        imageUrl: Value(article.imageUrl),
        publishedAt: article.publishedAt.toIso8601String(),
      );
    }).toList();
  }

  domain.NewsArticle _mapToDomain(db.NewsArticle row) {
    return domain.NewsArticle(
      id: row.id,
      title: row.title,
      description: row.description,
      imageUrl: row.imageUrl,
      publishedAt: DateTime.parse(row.publishedAt),
    );
  }
}
