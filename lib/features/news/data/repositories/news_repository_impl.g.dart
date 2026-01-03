// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(newsRepository)
final newsRepositoryProvider = NewsRepositoryProvider._();

final class NewsRepositoryProvider
    extends $FunctionalProvider<NewsRepository, NewsRepository, NewsRepository>
    with $Provider<NewsRepository> {
  NewsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NewsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NewsRepository create(Ref ref) {
    return newsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewsRepository>(value),
    );
  }
}

String _$newsRepositoryHash() => r'c628b237310d11d6aa7207d5f02a8f9e1dc0f48b';
