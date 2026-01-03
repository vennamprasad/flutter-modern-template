import 'package:flutter/material.dart';
import 'package:flutter_modern_template/core/domain/repositories/settings_repository.dart';
import 'package:flutter_modern_template/core/data/repositories/local_settings_repository.dart';
import 'package:flutter_modern_template/core/presentation/providers/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Reuse the generated mocks from the file we already configured
// We don't need to re-run build_runner if the Mock definition matches.
// However, we are removing ThemeRepository mock eventually.
// For now, let's keep using the existing generated file but we will focus on SettingsRepository.
@GenerateNiceMocks([
  MockSpec<SettingsRepository>(),
])
import 'theme_controller_test.mocks.dart';

void main() {
  late MockSettingsRepository mockSettingsRepository;
  late ProviderContainer container;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();

    // Create a ProviderContainer that overrides the repository provider
    container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(mockSettingsRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ThemeController Tests', () {
    test('initial state should match repository value (Dark)', () async {
      // Arrange
      when(mockSettingsRepository.getThemeMode())
          .thenAnswer((_) async => ThemeMode.dark);

      // Act
      final controller = container.listen(
        themeControllerProvider,
        (previous, next) {},
      );

      // Wait for the initial build to complete
      await container.read(themeControllerProvider.future);

      // Assert
      expect(controller.read(), AsyncData(ThemeMode.dark));
      verify(mockSettingsRepository.getThemeMode()).called(1);
    });

    test('updateThemeMode should update state and call repository', () async {
      // Arrange
      when(mockSettingsRepository.getThemeMode())
          .thenAnswer((_) async => ThemeMode.light);

      // Act
      // 1. Initialize
      await container.read(themeControllerProvider.future);

      // 2. Add listener to track state changes
      container.listen(themeControllerProvider, (previous, next) {});

      // 3. Update
      await container
          .read(themeControllerProvider.notifier)
          .updateThemeMode(ThemeMode.dark);

      // Assert
      expect(container.read(themeControllerProvider).value, ThemeMode.dark);
      verify(mockSettingsRepository.setThemeMode(ThemeMode.dark)).called(1);
    });
  });
}
