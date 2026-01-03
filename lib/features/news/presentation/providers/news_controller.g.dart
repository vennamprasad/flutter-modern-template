// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsController)
final newsControllerProvider = NewsControllerProvider._();

final class NewsControllerProvider
    extends $StreamNotifierProvider<NewsController, List<NewsArticle>> {
  NewsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newsControllerHash();

  @$internal
  @override
  NewsController create() => NewsController();
}

String _$newsControllerHash() => r'814b5a8238622491140d51cd826bd1600cb84584';

abstract class _$NewsController extends $StreamNotifier<List<NewsArticle>> {
  Stream<List<NewsArticle>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<NewsArticle>>, List<NewsArticle>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<NewsArticle>>, List<NewsArticle>>,
        AsyncValue<List<NewsArticle>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
