// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_size_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FontSizeController)
final fontSizeControllerProvider = FontSizeControllerProvider._();

final class FontSizeControllerProvider
    extends $AsyncNotifierProvider<FontSizeController, double> {
  FontSizeControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fontSizeControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fontSizeControllerHash();

  @$internal
  @override
  FontSizeController create() => FontSizeController();
}

String _$fontSizeControllerHash() =>
    r'0afc64427959cae5be01dbc2f065465fdf9a60f9';

abstract class _$FontSizeController extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<double>, double>,
        AsyncValue<double>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
