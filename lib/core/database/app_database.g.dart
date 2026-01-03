// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NewsArticlesTable extends NewsArticles
    with TableInfo<$NewsArticlesTable, NewsArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<String> publishedAt = GeneratedColumn<String>(
      'published_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, imageUrl, publishedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news_articles';
  @override
  VerificationContext validateIntegrity(Insertable<NewsArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewsArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}published_at'])!,
    );
  }

  @override
  $NewsArticlesTable createAlias(String alias) {
    return $NewsArticlesTable(attachedDatabase, alias);
  }
}

class NewsArticle extends DataClass implements Insertable<NewsArticle> {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String publishedAt;
  const NewsArticle(
      {required this.id,
      required this.title,
      this.description,
      this.imageUrl,
      required this.publishedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['published_at'] = Variable<String>(publishedAt);
    return map;
  }

  NewsArticlesCompanion toCompanion(bool nullToAbsent) {
    return NewsArticlesCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      publishedAt: Value(publishedAt),
    );
  }

  factory NewsArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewsArticle(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      publishedAt: serializer.fromJson<String>(json['publishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'publishedAt': serializer.toJson<String>(publishedAt),
    };
  }

  NewsArticle copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          String? publishedAt}) =>
      NewsArticle(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        publishedAt: publishedAt ?? this.publishedAt,
      );
  NewsArticle copyWithCompanion(NewsArticlesCompanion data) {
    return NewsArticle(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewsArticle(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, imageUrl, publishedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsArticle &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.publishedAt == this.publishedAt);
}

class NewsArticlesCompanion extends UpdateCompanion<NewsArticle> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> imageUrl;
  final Value<String> publishedAt;
  final Value<int> rowid;
  const NewsArticlesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NewsArticlesCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required String publishedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        publishedAt = Value(publishedAt);
  static Insertable<NewsArticle> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? publishedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (publishedAt != null) 'published_at': publishedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NewsArticlesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? imageUrl,
      Value<String>? publishedAt,
      Value<int>? rowid}) {
    return NewsArticlesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<String>(publishedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsArticlesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NewsArticlesTable newsArticles = $NewsArticlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [newsArticles];
}

typedef $$NewsArticlesTableCreateCompanionBuilder = NewsArticlesCompanion
    Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String?> imageUrl,
  required String publishedAt,
  Value<int> rowid,
});
typedef $$NewsArticlesTableUpdateCompanionBuilder = NewsArticlesCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> imageUrl,
  Value<String> publishedAt,
  Value<int> rowid,
});

class $$NewsArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $NewsArticlesTable> {
  $$NewsArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));
}

class $$NewsArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $NewsArticlesTable> {
  $$NewsArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));
}

class $$NewsArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewsArticlesTable> {
  $$NewsArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);
}

class $$NewsArticlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NewsArticlesTable,
    NewsArticle,
    $$NewsArticlesTableFilterComposer,
    $$NewsArticlesTableOrderingComposer,
    $$NewsArticlesTableAnnotationComposer,
    $$NewsArticlesTableCreateCompanionBuilder,
    $$NewsArticlesTableUpdateCompanionBuilder,
    (
      NewsArticle,
      BaseReferences<_$AppDatabase, $NewsArticlesTable, NewsArticle>
    ),
    NewsArticle,
    PrefetchHooks Function()> {
  $$NewsArticlesTableTableManager(_$AppDatabase db, $NewsArticlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewsArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewsArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewsArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String> publishedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NewsArticlesCompanion(
            id: id,
            title: title,
            description: description,
            imageUrl: imageUrl,
            publishedAt: publishedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            required String publishedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              NewsArticlesCompanion.insert(
            id: id,
            title: title,
            description: description,
            imageUrl: imageUrl,
            publishedAt: publishedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NewsArticlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NewsArticlesTable,
    NewsArticle,
    $$NewsArticlesTableFilterComposer,
    $$NewsArticlesTableOrderingComposer,
    $$NewsArticlesTableAnnotationComposer,
    $$NewsArticlesTableCreateCompanionBuilder,
    $$NewsArticlesTableUpdateCompanionBuilder,
    (
      NewsArticle,
      BaseReferences<_$AppDatabase, $NewsArticlesTable, NewsArticle>
    ),
    NewsArticle,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NewsArticlesTableTableManager get newsArticles =>
      $$NewsArticlesTableTableManager(_db, _db.newsArticles);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appDatabaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'8c69eb46d45206533c176c88a926608e79ca927d';
