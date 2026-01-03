// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_pagination_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsPaginationState)
final newsPaginationStateProvider = NewsPaginationStateProvider._();

final class NewsPaginationStateProvider
    extends $NotifierProvider<NewsPaginationState, bool> {
  NewsPaginationStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newsPaginationStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newsPaginationStateHash();

  @$internal
  @override
  NewsPaginationState create() => NewsPaginationState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$newsPaginationStateHash() =>
    r'1ccc9b1e089bdd1b958ff9d6fb8c2dbef194f954';

abstract class _$NewsPaginationState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
