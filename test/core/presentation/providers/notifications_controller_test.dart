import 'package:flutter_modern_template/core/data/repositories/local_settings_repository.dart';
import 'package:flutter_modern_template/core/presentation/providers/notifications_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'theme_controller_test.mocks.dart';

void main() {
  late MockSettingsRepository mockSettingsRepository;
  late ProviderContainer container;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(mockSettingsRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('NotificationsController Tests', () {
    test('initial state should match repository value', () async {
      when(mockSettingsRepository.getNotificationsEnabled())
          .thenAnswer((_) async => true);

      final controller = container.listen(
        notificationsControllerProvider,
        (previous, next) {},
      );

      await container.read(notificationsControllerProvider.future);

      expect(controller.read(), AsyncData(true));
      verify(mockSettingsRepository.getNotificationsEnabled()).called(1);
    });

    test('toggleNotifications should update state and call repository', () async {
      when(mockSettingsRepository.getNotificationsEnabled())
          .thenAnswer((_) async => true);

      await container.read(notificationsControllerProvider.future);
      container.listen(notificationsControllerProvider, (previous, next) {});

      await container
          .read(notificationsControllerProvider.notifier)
          .toggleNotifications(false);

      expect(container.read(notificationsControllerProvider).value, false);
      verify(mockSettingsRepository.setNotificationsEnabled(false)).called(1);
    });
  });
}
