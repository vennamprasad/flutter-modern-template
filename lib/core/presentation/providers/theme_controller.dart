import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/local_settings_repository.dart';

part 'theme_controller.g.dart';

/// [ThemeController]
///
/// A "Business Logic Component" for the Theme feature.
/// It holds the current state (AsyncValue<ThemeMode>) and exposes methods to change it.
/// It talks to the Repository, keeping the UI unaware of storage details.
@riverpod
class ThemeController extends _$ThemeController {
  @override
  Future<ThemeMode> build() async {
    // 1. Get the repository dependency
    final repository = ref.watch(settingsRepositoryProvider);
    // 2. Load the initial value
    return repository.getThemeMode();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    // 1. Optimistically update the state (UI updates instantly)
    state = AsyncData(mode);

    // 2. Persist the change (Fire and forget, or await if critical)
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setThemeMode(mode);
  }
}
