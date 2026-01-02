// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [ThemeController]
///
/// A "Business Logic Component" for the Theme feature.
/// It holds the current state (AsyncValue<ThemeMode>) and exposes methods to change it.
/// It talks to the Repository, keeping the UI unaware of storage details.

@ProviderFor(ThemeController)
final themeControllerProvider = ThemeControllerProvider._();

/// [ThemeController]
///
/// A "Business Logic Component" for the Theme feature.
/// It holds the current state (AsyncValue<ThemeMode>) and exposes methods to change it.
/// It talks to the Repository, keeping the UI unaware of storage details.
final class ThemeControllerProvider
    extends $AsyncNotifierProvider<ThemeController, ThemeMode> {
  /// [ThemeController]
  ///
  /// A "Business Logic Component" for the Theme feature.
  /// It holds the current state (AsyncValue<ThemeMode>) and exposes methods to change it.
  /// It talks to the Repository, keeping the UI unaware of storage details.
  ThemeControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();
}

String _$themeControllerHash() => r'30d40958c73ba0d20948b56a53f9e22bcdd837d8';

/// [ThemeController]
///
/// A "Business Logic Component" for the Theme feature.
/// It holds the current state (AsyncValue<ThemeMode>) and exposes methods to change it.
/// It talks to the Repository, keeping the UI unaware of storage details.

abstract class _$ThemeController extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
        AsyncValue<ThemeMode>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
