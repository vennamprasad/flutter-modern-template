import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

// --- Tables ---

class NewsArticles extends Table {
  TextColumn get id => text()(); // API ID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get publishedAt => text()(); // ISO-8601 String

  @override
  Set<Column> get primaryKey => {id};
}

// --- Database ---

@DriftDatabase(tables: [NewsArticles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Watch all news articles (Reactive)
  Stream<List<NewsArticle>> watchAllNews() {
    return select(newsArticles).watch();
  }

  /// Get all news articles (One-shot)
  Future<List<NewsArticle>> getAllNews() {
    return select(newsArticles).get();
  }

  /// Insert list of news (Batch)
  Future<void> insertNews(List<Insertable<NewsArticle>> articles) async {
    await batch((batch) {
      batch.insertAll(newsArticles, articles);
    });
  }

  /// Delete all news
  Future<void> clearNews() {
    return delete(newsArticles).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// --- Provider ---

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
